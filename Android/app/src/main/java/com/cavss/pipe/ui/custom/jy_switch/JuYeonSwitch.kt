package com.cavss.pipe.ui.custom.jy_switch

import android.content.Context
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.BlurMaskFilter
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Paint
import android.graphics.RectF
import android.graphics.Shader
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.AttributeSet
import android.util.Log
import android.view.MotionEvent
import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.view.setPadding
import com.cavss.pipe.R

class JuYeonSwitch(context: Context, attrs: AttributeSet?) : View(context, attrs) {

    private var attr_switchOn = false
    private var attr_switchColor = Color.GREEN
    private var attr_bgColor = Color.LTGRAY
    private var attr_onImage: Drawable? = ContextCompat.getDrawable(context, R.drawable.ic_launcher_background)
    private var attr_offImage: Drawable? = ContextCompat.getDrawable(context, R.drawable.ic_launcher_background)
    private var attr_width = 10f
    private var attr_height = 10f


    private var paint_switch: Paint = Paint(Paint.ANTI_ALIAS_FLAG)
    private var paint_background: Paint = Paint(Paint.ANTI_ALIAS_FLAG)
    private var paint_background_border: Paint = Paint(Paint.ANTI_ALIAS_FLAG)

    private var textColour : Int = Color.WHITE
    private var borderColour : Int = Color.WHITE
    private var backgroundColour : Int = Color.WHITE
    private var colour_shadow_top : Int = Color.WHITE
    private var colour_shadow_bottom : Int = Color.WHITE
    private var colour_shadow : Int = Color.LTGRAY
    private fun whitnessColour(rgb: Int, factor: Float): Int {
        val red = (Color.red(rgb) + (255 - Color.red(rgb)) * factor).toInt().coerceIn(0, 255)
        val green = (Color.green(rgb) + (255 - Color.green(rgb)) * factor).toInt().coerceIn(0, 255)
        val blue = (Color.blue(rgb) + (255 - Color.blue(rgb)) * factor).toInt().coerceIn(0, 255)
        return Color.rgb(red, green, blue)
    }
    private fun setColours(){
        try{
            // 현재 시스템 테마 모드 가져오기
            val currentNightMode = resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK
            if (currentNightMode == Configuration.UI_MODE_NIGHT_YES){
                // Dark 모드
                textColour = Color.WHITE
                borderColour = Color.LTGRAY
                colour_shadow_bottom = whitnessColour(Color.BLACK, 0.25f)
                colour_shadow_top = whitnessColour(Color.BLACK, 0.125f)
                backgroundColour = whitnessColour(Color.BLACK, 0.0f)
                colour_shadow = Color.DKGRAY
            } else {
                // Light 모드
                textColour = Color.BLACK
                borderColour = Color.LTGRAY
                backgroundColour = Color.WHITE
                colour_shadow_top = Color.rgb( 227, 240, 250)
                colour_shadow_bottom = Color.rgb( 192, 211, 246)
                colour_shadow = Color.LTGRAY
            }
        }catch(e:Exception){
            Log.e("mException", "JuYeonSwitch, setColours // Exception : ${e.localizedMessage}")
        }
    }

    init {
        try{
            setColours()
            attrs?.let {
                val typedArray = context.obtainStyledAttributes(it, R.styleable.JuYeonSwitch)
                attr_onImage = ContextCompat.getDrawable(context, typedArray.getResourceId(R.styleable.JuYeonSwitch_onImage, 0))
                attr_offImage = ContextCompat.getDrawable(context, typedArray.getResourceId(R.styleable.JuYeonSwitch_offImage, 0))

                attr_switchOn = typedArray.getBoolean(R.styleable.JuYeonSwitch_switchOn, false)
                attr_switchColor = typedArray.getColor(R.styleable.JuYeonSwitch_switchColor, Color.WHITE)
                attr_bgColor = typedArray.getColor(R.styleable.JuYeonSwitch_backgroundColor, Color.BLACK)
                typedArray.recycle()
            }

            paint_background_border.apply {
                color = borderColour
                style = Paint.Style.STROKE // Paint의 스타일을 STROKE로 설정하여 테두리를 그리도록 합니다
            }
            paint_background.apply {
                color = attr_bgColor
            }
            this.setPadding(10)
            setWillNotDraw(false)
        }catch (e:Exception){
            Log.e("mException", "JuYeonSwitch, init // Exception : ${e.localizedMessage}")
        }
    }

    private fun innerGradation() : LinearGradient {
        val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
        if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
            // 나이트 모드일 때 텍스트 색상
            return LinearGradient(
                0f,
                0f,
                0f,
                height.toFloat(),
                intArrayOf(colour_shadow_bottom, colour_shadow_top, backgroundColour), // 그라데이션 색상 배열
                floatArrayOf(0.0f, 0.5f, 1.0f), // 그라데이션 위치 배열
                Shader.TileMode.CLAMP
            )
        } else {
            // 라이트 모드일 때 텍스트 색상
            return LinearGradient(
                0f,
                0f,
                0f,
                height.toFloat(),
                intArrayOf(backgroundColour, colour_shadow_top, colour_shadow_bottom), // 그라데이션 색상 배열
                floatArrayOf(0.0f, 0.5f, 1.0f), // 그라데이션 위치 배열
                Shader.TileMode.CLAMP
            )
        }
    }
    private fun switchGradation() : LinearGradient {
        val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
        if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
            // 나이트 모드일 때 텍스트 색상
            return LinearGradient(
                0f,
                0f,
                width.toFloat(),
                height.toFloat(),
                intArrayOf(colour_shadow_bottom, colour_shadow_top, backgroundColour), // 그라데이션 색상 배열
                floatArrayOf(0.0f, 0.5f, 1.0f), // 그라데이션 위치 배열
                Shader.TileMode.CLAMP
            )
        } else {
            // 라이트 모드일 때 텍스트 색상
            return LinearGradient(
                0f,
                0f,
                width.toFloat(),
                height.toFloat(),
                intArrayOf(colour_shadow_bottom, Color.CYAN), // 그라데이션 색상 배열
                floatArrayOf(0.0f, 1.0f), // 그라데이션 위치 배열
                Shader.TileMode.CLAMP
            )
        }
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)

        val width = MeasureSpec.getSize(widthMeasureSpec)
        val height = MeasureSpec.getSize(heightMeasureSpec)

        // Set width and height in dp
        attr_width = width.toFloat()
        attr_height = height.toFloat()

        paint_switch.apply {
            shader = switchGradation() // Paint에 그라데이션 설정
        }
    }

    // Drawable을 Bitmap으로 변환하는 함수
    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable) {
            return drawable.bitmap
        }
        val bitmap = Bitmap.createBitmap(drawable.intrinsicWidth, drawable.intrinsicHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }


    private var attr_radius = 100f
    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)
    private var switchRadius = 0f
    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        val rx = attr_radius // 가로 방향 둥근 모서리의 반경
        val ry = attr_radius // 세로 방향 둥근 모서리의 반경
        val distance = attr_radius / 10
        val mBlurRadius = 10f
        canvas?.apply {
            // 4시 방향
            paint.color = colour_shadow
            paint.maskFilter = BlurMaskFilter(mBlurRadius, BlurMaskFilter.Blur.NORMAL)
            val nLeft = 0f + (distance * 3)
            val nTop = 0f + (distance * 3)
            val nRight = width.toFloat() - (distance * 0)
            val nBottom = height.toFloat() - (distance * 0)
            val nRectF = RectF(nLeft,nTop,nRight,nBottom)
            drawRoundRect(nRectF, rx, ry, paint)

            // 배경 shadow
            paint.shader = innerGradation()
            paint.maskFilter = null
            val oLeft = 0f + (distance * 1)
            val oTop = 0f + (distance * 1)
            val oRight = width.toFloat() - (distance * 1)
            val oBottom = height.toFloat() - (distance * 1)
            val oRectF = RectF(oLeft,oTop,oRight,oBottom)
            drawRoundRect(oRectF, rx, ry, paint)

            // 배경
            paint.color = backgroundColour
            paint.shader = null
            val shadowGradationDistance = 25f
            paint.maskFilter = BlurMaskFilter(shadowGradationDistance * 2, BlurMaskFilter.Blur.NORMAL)
            val mLeft = 0f + (distance * 1) + shadowGradationDistance
            val mTop = 0f + (distance * 1) + shadowGradationDistance
            val mRight = width.toFloat() - (distance * 1) - shadowGradationDistance
            val mBottom = height.toFloat() - (distance * 1) - shadowGradationDistance
            val mRectF = RectF(mLeft,mTop,mRight,mBottom)
            drawRoundRect(mRectF, rx, ry, paint)
        }


        // 스위치 버튼 그리기
        switchRadius = (height.toFloat() / 2) - (distance * 2)
        val x = if (attr_switchOn) {
            0f + (distance * 1)
        } else {
            width.toFloat() - (distance * 3) - (switchRadius * 2)
        }
        val centerX = (x + switchRadius) + (distance * 1) // 원의 중심 X 좌표
        val centerY = height.toFloat() / 2 // 원의 중심 Y 좌표

        // 원 그리기
        canvas?.drawCircle(centerX, centerY, switchRadius  - (distance * 0), paint_switch)

        // switchDrawable의 위치 계산
        val switchDrawable = if (attr_switchOn) attr_onImage else attr_offImage
        switchDrawable?.let {
            val drawableWidth = switchRadius // 원하는 너비로 축소
            val drawableHeight = switchRadius // 원하는 높이로 축소
            val bitmap = Bitmap.createScaledBitmap(drawableToBitmap(switchDrawable), drawableWidth.toInt(), drawableHeight.toInt(), true)
            canvas?.drawBitmap(bitmap, centerX - (distance * 2) - (distance/2), centerY - (distance * 2) - (distance/2), null)
        }
    }

    interface JuYeonSwitchListener {
        fun onSwitchChanged(value: Drawable?)
    }
    private var switchListener: JuYeonSwitchListener? = null
    fun setOnSwitchChangedListener(listener: JuYeonSwitchListener) {
        switchListener = listener
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
        if (event?.action == MotionEvent.ACTION_DOWN) {
            attr_switchOn = !attr_switchOn
            switchListener?.onSwitchChanged(if (attr_switchOn) attr_onImage else attr_offImage)
            invalidate()
            return true
        }
        return super.onTouchEvent(event)
    }
}

