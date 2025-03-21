package com.cavss.pipe.ui.custom.jy_address

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
import android.graphics.drawable.GradientDrawable
import android.text.Editable
import android.text.TextWatcher
import android.util.AttributeSet
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.animation.BounceInterpolator
import android.widget.LinearLayout
import android.widget.PopupWindow
import android.widget.TextView
import androidx.core.view.setMargins
import androidx.core.view.setPadding
import androidx.core.widget.addTextChangedListener
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

class JuYeonAddress @JvmOverloads constructor (
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attrs, defStyleAttr) {
    inner class AddressModel(
        val country : List<CountryModel>
    ){}
    inner class CountryModel(
        val countryTitle : String,
        val cities : List<CityModel>
    )
    // 시(city),
    inner class CityModel(
        val cityTitle : String,
        val districts : List<DistrictModel>
    )
    // 구(district),
    inner class DistrictModel(
        val districtTitle : String,
        val neighborhoods : List<NeighborHoodModel>
    )
    // 동(neighborhood)
    inner class NeighborHoodModel(
        val neighborhoodTitle : String,
        val detailAddress : String
    )

    private fun Int.dpToPx(context : Context): Int {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            this.toFloat(),
            context.resources.displayMetrics
        ).toInt()
    }

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

    // 이벤트 리스너 정의
    interface OnTextChangedListener {
        fun onTextChanged(country: String, city: String, district: String, neighborhood: String)
    }

    private var onTextChangedListener: OnTextChangedListener? = null
    fun setOnTextChangedListener(listener: OnTextChangedListener) {
        onTextChangedListener = listener
    }


    private val countryTextView : TextView = TextView(context)
    private val cityTextView : TextView = TextView(context)
    private val districtTextView : TextView = TextView(context)
    private val neighborhoodTextView : TextView = TextView(context)
    private fun setDropDownMenu(title : String, list : List<String>, textView : TextView)  {
        try{
            val dropdownAdapter = DropdownAdapter()
            val recyclerView: RecyclerView = RecyclerView(context).apply {
                adapter = dropdownAdapter.apply {
                    setMenu(list)
                }
                layoutParams = LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                layoutManager = LinearLayoutManager(context).apply{
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE // 네모난 박스 형태로 설정
                    setColor(backgroundColour)
                    setStroke(1.dpToPx(context), textColour) // 테두리 두께와 색상 설정
                }
                setItemViewCacheSize(0)
                setHasFixedSize(true)
            }
            val popupWindow: PopupWindow = PopupWindow(recyclerView, ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT).apply {
                isOutsideTouchable = true
                isFocusable = true
                setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
            }
            textView.apply {
                text = title
                textSize = 15f
                typeface = Typeface.defaultFromStyle(Typeface.BOLD)
                setTextColor(textColour)
                setPadding(30,5,30,5)
                layoutParams = LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.WRAP_CONTENT, // 가로 크기
                    LinearLayout.LayoutParams.WRAP_CONTENT // 세로 크기
                ).apply {
//                    setMargins(0,2.dpToPx(context),0,2.dpToPx(context))
                    setMargins(0.dpToPx(context))
                }
                setOnClickListener {
                    // bounce 애니메이션 적용
                    val animator = ObjectAnimator.ofFloat(recyclerView, "translationY", -100f, 0f)
                    animator.duration = 500
                    animator.interpolator = BounceInterpolator()
                    animator.start()
                    popupWindow.showAsDropDown(this)
                }
                addTextChangedListener { text ->
                    onTextChangedListener?.onTextChanged(
                        countryTextView.text.toString(),
                        cityTextView.text.toString(),
                        districtTextView.text.toString(),
                        neighborhoodTextView.text.toString()
                    )
                }
            }
            dropdownAdapter.setViews(textView,popupWindow)
        }catch (e:Exception){
            Log.e("mException", "JuYeonAddress, setDropDownMenu // Exception : ${e.localizedMessage}")
        }
    }
    private inner class DropdownAdapter() : RecyclerView.Adapter<DropdownViewHolder>() {
        private var mList : ArrayList<String> = arrayListOf()
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
        fun setMenu(items: List<String>) {
            try {
                val mItem = arrayListOf<String>()
                items.forEach { menu : String ->
                    mItem.add(menu)
                }

                val oldList = mList
                val diffResult = DiffUtil.calculateDiff(StringDiffUtil(oldList, mItem))
                diffResult.dispatchUpdatesTo(this@DropdownAdapter) // 이 부분이 수정되었습니다.

                mList.clear()
                mList.addAll(mItem)

            }catch (e:Exception){
                Log.e("mException", "JuYeonAddress, DropdownAdapter // Exception : ${e.localizedMessage}")
            }
        }

        private var textView : TextView? = null
        private var popupWindow: PopupWindow? = null
        fun setViews(textView : TextView, popupWindow: PopupWindow){
            this.textView = textView
            this.popupWindow = popupWindow
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DropdownViewHolder {
            val textView = TextView(parent.context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                setPadding(16, 16, 16, 16)
                gravity = Gravity.CENTER_VERTICAL // text gravity
                textSize = 16f // text size
                setTextColor(textColour) // text color
            }
            return DropdownViewHolder(textView)
        }
        override fun onBindViewHolder(holder: DropdownViewHolder, position: Int) {
            holder.bind(mList[position], textView, popupWindow)
        }
        override fun getItemCount(): Int = mList.size
    }
    private inner class DropdownViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(item: String, textView : TextView?, popupWindow : PopupWindow?) {
            (itemView as TextView).apply {
                text = item
                setOnClickListener {
                    textView?.text = item
                    popupWindow?.dismiss()
                }
            }
        }
    }

    private var attr_radius = 100f
    init{
        setColours()
        this@JuYeonAddress.apply {
            orientation = HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL

            setDropDownMenu("국가", listOf("🇰🇷", "🇮🇩", "🇦🇺", "🇪🇸", "🇮🇹"), countryTextView)
            setDropDownMenu("시・도", listOf("서울특별시", "인천광역시", "부산광역시", "여수시", "울산광역시"), cityTextView)
            setDropDownMenu("시・구・군", listOf("종로구", "동구", "서구", "금정구", "미추홀구"), districtTextView)
            setDropDownMenu("읍・면・동", listOf("창신 1동", "창신 2동", "창신 3동", "창신 4동", "숭인 1동"), neighborhoodTextView)

            addView(countryTextView)
            addView(cityTextView)
            addView(districtTextView)
            addView(neighborhoodTextView)
            setPadding(30)
        }
        setWillNotDraw(false)

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

val json = """
    
""".trimIndent()