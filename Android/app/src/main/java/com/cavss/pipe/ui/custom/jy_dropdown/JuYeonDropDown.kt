package com.cavss.pipe.ui.custom.jy_dropdown

import android.animation.ObjectAnimator
import android.content.Context
import android.graphics.BlurMaskFilter
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Paint
import android.graphics.RectF
import android.graphics.Shader
import android.graphics.Typeface
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import android.graphics.drawable.GradientDrawable
import android.text.TextUtils
import android.util.AttributeSet
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.animation.BounceInterpolator
import android.widget.LinearLayout
import android.widget.PopupWindow
import android.widget.ScrollView
import android.widget.TextView
import androidx.core.graphics.drawable.DrawableCompat
import androidx.core.view.setPadding
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.R

class JuYeonDropDown @JvmOverloads constructor (
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attrs, defStyleAttr) {

    private lateinit var popupWindow: PopupWindow
    private lateinit var recyclerView: RecyclerView
    private lateinit var titleTextView : TextView
    private lateinit var emojiTextView : TextView
    private lateinit var downMarkTextView : TextView
    private lateinit var dropdownAdapter : DropdownAdapter

    private var attrEmoji : String = ""
    private var attrText : String = ""
    private var attrTextColour : Int = Color.BLACK
    private var attrTextSize : Float = 10f
    private var attrBackgroundColour : Int = Color.WHITE

    fun Int.dpToPx(context : Context): Int {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            this.toFloat(),
            context.resources.displayMetrics
        ).toInt()
    }

    private var onItemClick: (String) -> Unit = {}
    fun setMenuItemClick(menu : (String) -> Unit){
        onItemClick = menu
    }

    private var mList : ArrayList<String> = arrayListOf()
    fun setMenu(items: List<String>) {
        try {
            val mItem = arrayListOf<String>()
            items.forEach { menu : String ->
                mItem.add(menu)
            }

            val oldList = mList
            val diffResult = DiffUtil.calculateDiff(StringDiffUtil(oldList, mItem))
            diffResult.dispatchUpdatesTo(dropdownAdapter) // 이 부분이 수정되었습니다.

            mList.clear()
            mList.addAll(mItem )

        }catch (e:Exception){
            Log.e("mException", "JuYeonDropdown, setMenu // Exception : ${e.localizedMessage}")
        }
    }

    private var colour_shadow_top : Int = Color.WHITE
    private var colour_shadow_bottom : Int = Color.WHITE
    private var colour_shadow : Int = Color.LTGRAY
    private fun whitnessColour(rgb: Int, factor: Float): Int {
        val red = (Color.red(rgb) + (255 - Color.red(rgb)) * factor).toInt().coerceIn(0, 255)
        val green = (Color.green(rgb) + (255 - Color.green(rgb)) * factor).toInt().coerceIn(0, 255)
        val blue = (Color.blue(rgb) + (255 - Color.blue(rgb)) * factor).toInt().coerceIn(0, 255)
        return Color.rgb(red, green, blue)
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
                intArrayOf(colour_shadow_bottom, colour_shadow_top, attrBackgroundColour), // 그라데이션 색상 배열
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
                intArrayOf(attrBackgroundColour, colour_shadow_top, colour_shadow_bottom), // 그라데이션 색상 배열
                floatArrayOf(0.0f, 0.5f, 1.0f), // 그라데이션 위치 배열
                Shader.TileMode.CLAMP
            )
        }
    }

    init {
        try{
            dropdownAdapter = DropdownAdapter()

            val typedArray = context.obtainStyledAttributes(attrs, R.styleable.JuYeonDropDown)
            attrEmoji = typedArray.getString(R.styleable.JuYeonDropDown_emoji) ?: "" // 수정된 부분
            attrText = typedArray.getString(R.styleable.JuYeonDropDown_text) ?: ""
            attrTextSize = typedArray.getDimension(R.styleable.JuYeonDropDown_textSize, 16f)
            val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
            if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
                // 나이트 모드일 때 텍스트 색상
                attrBackgroundColour = Color.BLACK
                attrTextColour = Color.WHITE
                colour_shadow_bottom = whitnessColour(Color.BLACK, 0.25f)
                colour_shadow_top = whitnessColour(Color.BLACK, 0.125f)
                colour_shadow = Color.DKGRAY
            } else {
                // 라이트 모드일 때 텍스트 색상
                attrBackgroundColour = typedArray.getColor(R.styleable.JuYeonDropDown_backgroundColour, Color.WHITE)
                attrTextColour = typedArray.getColor(R.styleable.JuYeonDropDown_textColour, Color.BLACK)
                colour_shadow_top = Color.rgb( 227, 240, 250)
                colour_shadow_bottom = Color.rgb( 192, 211, 246)
                colour_shadow = Color.LTGRAY
            }
            typedArray.recycle()

            settingTextViews()
            settingRecyclerView()
            settingDropdownMenu()

            this@JuYeonDropDown.apply {
                orientation = HORIZONTAL
                gravity = Gravity.CENTER_VERTICAL
                setPadding(20)
                this.setOnClickListener {
                    // bounce 애니메이션 적용
                    val animator = ObjectAnimator.ofFloat(recyclerView, "translationY", -100f, 0f)
                    animator.duration = 500
                    animator.interpolator = BounceInterpolator()
                    animator.start()
                    popupWindow.showAsDropDown(this)
                }
                addView(emojiTextView)
                addView(titleTextView)
                addView(downMarkTextView)
            }
            setWillNotDraw(false)
        }catch (e:Exception){
            Log.e("mException", "JuYeonDropDown, init // Exception : ${e.localizedMessage}")
        }
    }

    private fun settingTextViews(){
        try{
            emojiTextView = TextView(context).apply {
                text = attrEmoji
                textSize = attrTextSize/2
                typeface = Typeface.defaultFromStyle(Typeface.BOLD)
                setTextColor(attrTextColour)

                // 좌우 margin 추가
                val margin = 10.dpToPx(context) // 원하는 margin 값
                val params = LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT
                ).apply {
                    marginStart = margin // 시작 부분 (좌측) margin
                    marginEnd = margin // 끝 부분 (우측) margin
                }
                layoutParams = params
            }
            titleTextView = TextView(context).apply {
                //text style
                text = attrText
                textSize = attrTextSize/2
                typeface = Typeface.defaultFromStyle(Typeface.BOLD)
                setTextColor(attrTextColour)
            }
            downMarkTextView = TextView(context).apply{
                text = " ▾ "
                textSize = attrTextSize
                setTextColor(attrTextColour)
            }
        }catch (e:Exception){
            Log.e("mException", "JuYeonDropDown, settingTextViews // Exception : ${e.localizedMessage}")
        }
    }
    private fun settingRecyclerView(){
        try{
            recyclerView = RecyclerView(context).apply {
                adapter = dropdownAdapter
                layoutParams = LinearLayout.LayoutParams(
                    this@JuYeonDropDown.width,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                ).apply {
                    // top margin
                    topMargin = 100.dpToPx(context)
                }

                layoutManager = LinearLayoutManager(context).apply{
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }

                background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE // 네모난 박스 형태로 설정
                    cornerRadius = 10f // 모든 모서리에 동일한 반지름을 적용
                    setStroke(1.dpToPx(context), attrTextColour) // 테두리 두께와 색상 설정
                }
                setItemViewCacheSize(0)
                setHasFixedSize(true)
            }
        }catch (e:Exception){
            Log.e("mException", "JuYeonDropDown, settingRecyclerview // Exception : ${e.localizedMessage}")
        }
    }
    private fun settingDropdownMenu(){
        try{
            popupWindow = PopupWindow(recyclerView, ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT).apply {
                isOutsideTouchable = true
                isFocusable = true
                setBackgroundDrawable(ColorDrawable(attrBackgroundColour))
            }
        }catch (e:Exception){
            Log.e("mException", "JuYeonDropDown, settingDropdownMenu // Exception : ${e.localizedMessage}")
        }
    }

    private inner class StringDiffUtil(private val oldList : ArrayList<String>, private val newList : List<String>) : DiffUtil.Callback() {
        override fun getOldListSize() = oldList.size
        override fun getNewListSize() = newList.size
        override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
            return oldList[oldItemPosition] == newList[newItemPosition]
        }
        override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
            return oldList[oldItemPosition] == newList[newItemPosition]
        }
    }
    private inner class DropdownAdapter : RecyclerView.Adapter<DropdownViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DropdownViewHolder {
            val textView = TextView(parent.context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    this@JuYeonDropDown.width,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                setPadding(16, 16, 16, 16)
                gravity = Gravity.CENTER_VERTICAL // text gravity
                textSize = 16f // text size
                isSingleLine = true
                ellipsize = TextUtils.TruncateAt.MARQUEE
                marqueeRepeatLimit = -1 // 무한 반복: marquee_forever와 동일
//                isFocusable = true
//                isFocusableInTouchMode = true
                setHorizontallyScrolling(true)
                setTextColor(attrTextColour) // text color
            }
            textView.requestFocus()
            textView.isSelected = true
            return DropdownViewHolder(textView)
        }
        override fun onBindViewHolder(holder: DropdownViewHolder, position: Int) {
            holder.bind(mList[position])
        }
        override fun getItemCount(): Int = mList.size
    }
    private inner class DropdownViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        init {
            itemView.setOnClickListener {
                val item = mList[bindingAdapterPosition]
                titleTextView.text = item
                onItemClick(item)
                popupWindow.dismiss()
            }
        }
        fun bind(item: String) {
            (itemView as TextView).apply {
                text = item
            }
        }
    }

    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)
    override fun onDraw(canvas: Canvas?) {
        val rx = 100f // 가로 방향 둥근 모서리의 반경
        val ry = 100f // 세로 방향 둥근 모서리의 반경
        val distance = 100f / 10
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
            paint.color = attrBackgroundColour
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