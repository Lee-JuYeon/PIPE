package com.cavss.pipe.ui.custom.simmer

import android.content.Context
import android.graphics.*
import android.graphics.drawable.Drawable
import android.view.animation.Animation
import android.view.animation.LinearInterpolator
import android.view.animation.Transformation
import androidx.annotation.ColorInt
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.toBitmap

class ShimmerDrawable(context: Context, private val color: Int) : Drawable() {
    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)
    private val shaderMatrix = Matrix()

    init {
        paint.shader = LinearGradient(0f, 0f, 100f, 0f,
            intArrayOf(ContextCompat.getColor(context, android.R.color.transparent),
                ContextCompat.getColor(context, color), ContextCompat.getColor(context, android.R.color.transparent)),
            floatArrayOf(0f, 0.5f, 1f), Shader.TileMode.CLAMP)
    }

    override fun draw(canvas: Canvas) {
        val bounds = bounds

        val matrix = shaderMatrix
        matrix.reset()
        matrix.setTranslate(bounds.left.toFloat(), bounds.top.toFloat())
        matrix.preRotate(45f, bounds.exactCenterX(), bounds.exactCenterY())

        paint.shader.setLocalMatrix(matrix)

        canvas.drawRect(bounds, paint)
    }

    override fun setAlpha(alpha: Int) {
        paint.alpha = alpha
    }

    override fun setColorFilter(colorFilter: ColorFilter?) {
        paint.colorFilter = colorFilter
    }

    override fun getOpacity(): Int = PixelFormat.TRANSLUCENT
}