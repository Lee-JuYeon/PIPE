package com.cavss.pipe.ui.custom.jy_picker

import android.content.Context
import android.content.res.Configuration
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.text.TextUtils
import android.util.AttributeSet
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.view.marginStart
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.R
import com.cavss.pipe.ui.custom.jy_calendar.JuYeonCalendar
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import java.util.Calendar
import java.util.Date

class JuYeonNumberPicker @JvmOverloads constructor (
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attrs, defStyleAttr) {

    private val picker : RecyclerView
    private var pickerAdapter : PickerAdapter? = null

    private var textColour : Int = Color.WHITE
    private fun setColours(){
        try{
            // 현재 시스템 테마 모드 가져오기
            val currentNightMode = resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK
            if (currentNightMode == Configuration.UI_MODE_NIGHT_YES){
                // Dark 모드
                textColour = Color.WHITE
            } else {
                // Light 모드
                textColour = Color.BLACK
            }
        }catch(e:Exception){
            Log.e("mException", "JuYeonSwitch, setColours // Exception : ${e.localizedMessage}")
        }
    }

    private var attr_height : Int = 0
    init {
        setColours()
        attrs?.let {
            val density = resources.displayMetrics.density
            val typedArray = context.obtainStyledAttributes(it, R.styleable.JuYeonNumberPicker)
            val heightTypedArray = typedArray.getDimension(R.styleable.JuYeonNumberPicker_itemHeight, 0f)
//            attr_height = (heightTypedArray * density + 0.5f).toInt()
            attr_height = heightTypedArray.toInt()
            typedArray.recycle()
        }

        pickerAdapter = PickerAdapter()
        picker = RecyclerView(context).apply {
            adapter = pickerAdapter.apply {

            }
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                attr_height * 2
            )
            layoutManager = LinearLayoutManager(context).apply{
                orientation = LinearLayoutManager.VERTICAL
                isItemPrefetchEnabled = false
            }
            setItemViewCacheSize(0)
            setHasFixedSize(true)
        }

        this.apply {
            addView(picker)
        }
    }

    fun updatePickerList(list : List<String>){
        pickerAdapter?.updateList(list)
    }
    inner class StringDiffUtil(private val oldList : ArrayList<String>, private val newList : List<String>) : DiffUtil.Callback() {
        override fun getOldListSize() = oldList.size
        override fun getNewListSize() = newList.size
        override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
            return oldList[oldItemPosition] == newList[newItemPosition]
        }
        override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
            return oldList[oldItemPosition] == newList[newItemPosition]
        }
    }
    inner class PickerAdapter : RecyclerView.Adapter<TextViewHolder>(){

        private var mList : ArrayList<String> = arrayListOf<String>()
        fun updateList(newItems : List<String>?){
            try{
                val oldList = mList
                val newList = newItems ?: arrayListOf()
                val diffResult = DiffUtil.calculateDiff(StringDiffUtil(oldList, newList))
                diffResult.dispatchUpdatesTo(this@PickerAdapter) // 이 부분이 수정되었습니다.
                mList.clear()
                mList.addAll(newItems ?: arrayListOf())
                Log.d("mDebug", "JuYeonNumberPicker, PickerAdapter, updateList // updateList success")
            }catch (e:Exception){
                Log.e("mException", "JuYeonNumberPicker, PickerAdapter, updateList // Exception : ${e.message}")
            }
        }
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TextViewHolder {
           val textView = TextView(context).apply {
               val marginParams = LinearLayout.LayoutParams(
                   LinearLayout.LayoutParams.WRAP_CONTENT,
                   attr_height
               )
               marginParams.setMargins(0, 2, 0, 2)
               layoutParams = marginParams
               gravity = Gravity.CENTER
               textSize = 15f
               maxLines = 1
               ellipsize = TextUtils.TruncateAt.END
               setTextColor(textColour)
               setPadding(10,5,10,5)
           }
            return TextViewHolder(textView)
        }
        override fun getItemCount(): Int = mList.size

        var currentPosition: Int = RecyclerView.NO_POSITION
        override fun onBindViewHolder(holder: TextViewHolder, position: Int) {
            holder.bind(mList[position])
            currentPosition = position
            if (position == currentPosition) {
                holder.itemView.background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE // 네모난 박스 형태로 설정
                    cornerRadius = 20f // 모든 모서리에 동일한 반지름을 적용
                    setColor(Color.LTGRAY)
                }
            } else {
                holder.itemView.background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE // 네모난 박스 형태로 설정
                    cornerRadius = 20f // 모든 모서리에 동일한 반지름을 적용
                    setColor(Color.TRANSPARENT)
                }
            }
        }
        override fun onViewRecycled(holder: TextViewHolder) {
            try{
                super.onViewRecycled(holder)
                holder.let {
                    it.bind(null)
                }
            }catch (e:Exception){
                Log.e("mException", "JuYeonNumberPicker, onViewRecycled // Exception : ${e.message}")
            }
        }
    }

    inner class TextViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        // 날짜를 표시하는 TextView
        private val titleView: TextView = itemView as TextView

        fun bind(text: String?) {
            titleView.text = text
        }
    }
}