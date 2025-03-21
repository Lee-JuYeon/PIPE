package com.cavss.pipe.ui.custom.glassmorphism

import android.content.Context
import android.graphics.*
import android.graphics.drawable.Drawable
import android.util.AttributeSet
import androidx.constraintlayout.widget.ConstraintLayout
import com.cavss.pipe.R

class GlassmorphismConstraintLayout  @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : ConstraintLayout(context, attrs, defStyleAttr) {

    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)
    private val paddingSize = 130

    init {
        // padding
        setPadding(paddingSize, paddingSize, paddingSize, paddingSize)

        // 기존 설정 추가
        setWillNotDraw(false)
    }


    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)

        val gap = 20f

        canvas?.apply {
            // 배경 그라데이션 그리기
            paint.color = Color.WHITE
            paint.style = Paint.Style.STROKE
            paint.strokeWidth = 5f
            paint.maskFilter = null
            val roundedRectangle = RectF(
                gap ,
                gap ,
                width - gap ,
                height - gap
            )
            drawRoundRect(roundedRectangle, 80f, 80f, paint)

            // 배경 내부 블러로 그리기
            val blurSize = 30
            paint.maskFilter = BlurMaskFilter(blurSize.toFloat(), BlurMaskFilter.Blur.NORMAL)
            paint.color = Color.WHITE
            paint.strokeWidth = blurSize.toFloat()
            val blurStrokeRectangle = RectF(
                gap + blurSize,
                gap + blurSize,
                width - gap - blurSize,
                height - gap - blurSize
            )
            drawRoundRect(blurStrokeRectangle, 40f, 40f, paint)
        }
    }
}