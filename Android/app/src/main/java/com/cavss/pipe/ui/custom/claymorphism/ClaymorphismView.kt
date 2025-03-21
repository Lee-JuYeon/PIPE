package com.cavss.pipe.ui.custom.claymorphism

import android.content.Context
import android.graphics.*
import android.graphics.drawable.Drawable
import android.util.AttributeSet
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.view.setPadding

class ClaymorphismView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : ConstraintLayout(context, attrs, defStyleAttr) {

    private var textColour : Int = Color.BLACK
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
    private fun darkenColour(rgb: Int, factor: Float): Int {
        val red = (Color.red(rgb) * factor).toInt().coerceIn(0, 255)
        val green = (Color.green(rgb) * factor).toInt().coerceIn(0, 255)
        val blue = (Color.blue(rgb) * factor).toInt().coerceIn(0, 255)
        return Color.rgb(red, green, blue)
    }
    private fun setColours(){
        val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
        if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
            // 나이트 모드일 때 텍스트 색상
            textColour = Color.WHITE
            colour_shadow_bottom = whitnessColour(Color.BLACK, 0.25f)
            colour_shadow_top = whitnessColour(Color.BLACK, 0.125f)
            backgroundColour = whitnessColour(Color.BLACK, 0.0f)
            colour_shadow = Color.DKGRAY
        } else {
            // 라이트 모드일 때 텍스트 색상
            textColour = Color.BLACK
            backgroundColour = Color.WHITE
            colour_shadow_top = Color.rgb( 227, 240, 250)
            colour_shadow_bottom = Color.rgb( 192, 211, 246)
            colour_shadow = Color.LTGRAY
        }
    }

    private var attr_radius = 100f
    init {
        setColours()
        this.apply {

            setPadding(10)
        }
        setWillNotDraw(false)
    }

    private fun innerGradation() : LinearGradient{
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

    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)
    override fun onDraw(canvas: Canvas?) {
        val rx = attr_radius // 가로 방향 둥근 모서리의 반경
        val ry = attr_radius // 세로 방향 둥근 모서리의 반경
        val distance = attr_radius / 10
        val mBlurRadius = 10f

        super.onDraw(canvas)
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
    }
}
