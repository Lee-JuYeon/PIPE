package com.cavss.pipe.ui.custom.jy_bottomsheet

import android.app.Dialog
import android.content.Context
import android.graphics.*
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.util.Log
import android.view.*
import android.view.animation.Animation
import android.view.animation.TranslateAnimation
import android.widget.LinearLayout

class JuYeonBottomSheet(context: Context) : Dialog(context) {

    fun fetchContentView(view : View){
        backgroundView?.addView(view)
    }

    private var getGravity : Int = Gravity.BOTTOM
    private var backgroundColour : Int = Color.WHITE
    private var textColour : Int = Color.BLACK
    private var backgroundView : LinearLayout? = null

    init {
        setColours()
        setBackgroundView()
    }
    private fun setColours(){
        try{
            val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
            if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
                // 나이트 모드일 때 텍스트 색상
                textColour = Color.WHITE
                backgroundColour = Color.BLACK
            } else {
                // 라이트 모드일 때 텍스트 색상
                textColour = Color.BLACK
                backgroundColour = Color.WHITE
            }
        }catch (e:Exception){
            Log.e("mException", "CustomBottomSheet, setColours // Exception : ${e.localizedMessage}")
        }
    }
    private fun setDialog(){
        try{
            // 다이얼로그의 전체화면 설정
            window?.apply {
                setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
                setLayout(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                attributes.gravity = getGravity
                decorView.setPadding(10, if (getGravity == Gravity.BOTTOM) 0 else 5 , 10, if (getGravity == Gravity.BOTTOM) 5 else 0 )
            }
        }catch (e:Exception){
            Log.e("mException", "CustomBottomSheet, setDialog // Exception : ${e.localizedMessage}")
        }
    }
    private fun setBackgroundView(){
        backgroundView = LinearLayout(context)
        backgroundView?.apply {
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
            ).apply {
                // 좌우 margin 적용
                setMargins(10, if (getGravity == Gravity.BOTTOM) 0 else 5 , 10, if (getGravity == Gravity.BOTTOM) 5 else 0 )
            }
            gravity = Gravity.TOP
            orientation = LinearLayout.VERTICAL
            background = GradientDrawable().apply {
                setColor(backgroundColour)
                cornerRadii = if (getGravity == Gravity.BOTTOM) floatArrayOf(
                    50f, 50f, // top left corner
                    50f, 50f, // top right corner
                    0f, 0f, // bottom right corner
                    0f, 0f // bottom left corner
                ) else floatArrayOf(
                    0f, 0f, // top left corner
                    0f, 0f, // top right corner
                    50f, 50f, // bottom right corner
                    50f, 50f // bottom left corner
                )
                setStroke(3, textColour)
            }

            setPadding(
                10,
                if (getGravity == Gravity.BOTTOM) 100 else 10 ,
                10,
                if (getGravity == Gravity.BOTTOM) 10 else 100 ,
            )

            setOnShowListener {
                val showAnimation = TranslateAnimation(
                    0F, // fromXDelta
                    0F, // toXDelta
                    this.height.toFloat(), // fromYDelta
                    0f  // toYDelta
                ).apply {
                    duration = 250  // 애니메이션의 지속 시간 (밀리초)
                    setAnimationListener(object : Animation.AnimationListener {
                        override fun onAnimationStart(animation: Animation?) {
                            // 애니메이션 시작 후 처리
                        }
                        override fun onAnimationEnd(animation: Animation?) {
                            // 애니메이션이 끝난 후 처리
                        }
                        override fun onAnimationRepeat(animation: Animation?) {}
                    })
                }
                this.startAnimation(showAnimation)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(backgroundView!!)
        setDialog()
    }
}