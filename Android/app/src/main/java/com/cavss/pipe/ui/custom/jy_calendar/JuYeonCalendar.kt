package com.cavss.pipe.ui.custom.jy_calendar

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.text.TextUtils
import android.util.AttributeSet
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.cavss.pipe.util.typeconverter.dpToPx
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date


class JuYeonCalendar @JvmOverloads constructor (
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attrs, defStyleAttr) {


    private val calendar : Calendar
    private val currentMonthTextView : TextView
    private val weekTitleAdapter : WeekTitleAdapter
    private val calendarAdapter : CalendarAdapter
    private var textColour : Int = Color.BLACK
    private fun setColours(){
        val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
        textColour = if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
            Color.WHITE // 나이트 모드일 때 텍스트 색상
        } else {
            Color.BLACK // 라이트 모드일 때 텍스트 색상
        }
    }
    init {
        setColours()

        calendar = Calendar.getInstance()
        weekTitleAdapter = WeekTitleAdapter()
        calendarAdapter = CalendarAdapter()

        // CustomCalendarView 클래스를 초기화합니다.
        orientation = VERTICAL
        gravity = Gravity.CENTER_HORIZONTAL
        currentMonthTextView = TextView(context)
        currentMonthTextView.setTextColor(textColour)
        currentMonthTextView.textSize = 25f
        // TODO: 현재 월 표시
        currentMonthTextView.text = " ${calendar.get(Calendar.YEAR)}년 ${calendar.get(Calendar.MONTH) + 1}월 "


        // 상단 뷰를 추가합니다.
        val topView = LinearLayout(context)
        topView.layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT)
        topView.orientation = HORIZONTAL
        topView.gravity = Gravity.CENTER_HORIZONTAL

        val prevMonthButton = TextView(context)
        prevMonthButton.text = "⬅️"
        prevMonthButton.textSize = 25f
        prevMonthButton.setBackgroundColor(Color.TRANSPARENT)
        prevMonthButton.setOnClickListener {
            // TODO: 이전 달로 이동하는 기능 구현
            previousMonthAction()
        }

        val nextMonthButton = TextView(context)
        nextMonthButton.text = "➡️"
        nextMonthButton.textSize = 25f
        nextMonthButton.setBackgroundColor(Color.TRANSPARENT)
        nextMonthButton.setOnClickListener {
            // TODO: 다음 달로 이동하는 기능 구현
            nextMonthAction()
        }


        topView.addView(prevMonthButton)
        topView.addView(currentMonthTextView)
        topView.addView(nextMonthButton)

        // 월화수목금토 뷰
        val weekTitleRecyclerView = RecyclerView(context).apply {
            setHasFixedSize(true)
            setItemViewCacheSize(0)
            layoutParams = LayoutParams(
                LayoutParams.MATCH_PARENT,
                LayoutParams.WRAP_CONTENT
            )
            adapter = weekTitleAdapter.apply {

            }
            layoutManager = LinearLayoutManager(context).apply {
                orientation = LinearLayoutManager.HORIZONTAL
                isItemPrefetchEnabled = false
            }
        }

        // 달력 뷰
        val monthRecyclerview = RecyclerView(context).apply {
            setHasFixedSize(true)
            setItemViewCacheSize(0)
            layoutParams = LayoutParams(
                LayoutParams.MATCH_PARENT,
                LayoutParams.WRAP_CONTENT
            )
            adapter = calendarAdapter.apply {
                this.updateList(daysInMonthArray())
            }
            layoutManager = GridLayoutManager(context, 7).apply {
                isItemPrefetchEnabled = false
            }
            // 스크롤 비활성화
            isNestedScrollingEnabled = false

            // 그림자 효과 없애기
            overScrollMode = RecyclerView.OVER_SCROLL_NEVER
        }

        // 상단 뷰와 리사이클러뷰를 CustomCalendarView에 추가합니다.
        addView(topView)
        addView(weekTitleRecyclerView)
        addView(monthRecyclerview)
    }

    inner class WeekTitleAdapter() : RecyclerView.Adapter<TextViewHolder>(){
        private var weekTitleList = mutableListOf<String>("Sun", "Mon","Tue","Wed", "Thd", "Fri", "Sat")
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TextViewHolder {
            // 부모 뷰의 너비를 가져옵니다.
            val parentWidth = parent.measuredWidth

            // 각 아이템의 너비를 부모 뷰의 1/7로 설정합니다.
            val itemWidth = parentWidth / 7

            // TextView를 생성하고 레이아웃 파라미터를 설정합니다.
            val weekTitleView = TextView(context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    itemWidth,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                gravity = Gravity.START
                textSize = 16f
            }
            return TextViewHolder(weekTitleView)
        }
        override fun getItemCount(): Int {
            // 일자 리스트의 크기를 반환합니다.
            return weekTitleList.size
        }
        override fun onBindViewHolder(holder: TextViewHolder, position: Int) {
            // 각 아이템에 해당하는 일자를 설정합니다.
            holder.bind(weekTitleList[position])
        }

        override fun onViewRecycled(holder: TextViewHolder) {
            try{
                super.onViewRecycled(holder)
                holder.let {
                    it.bind(null)
                }
            }catch (e:Exception){
                Log.e("mException", "WeekTitleAdapter, onViewRecycled // Exception : ${e.message}")
            }
        }
    }
    inner class TextViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        // 날짜를 표시하는 TextView
        private val titleView: TextView = itemView as TextView

        fun bind(weekTitle: String?) {
            titleView.text = " ${weekTitle}"
            when(weekTitle){
                "Sun" -> {
                    titleView.setTypeface(null, Typeface.BOLD)
                    titleView.setTextColor(Color.RED)
                }
                "Sat" -> {
                    titleView.setTypeface(null, Typeface.BOLD)
                    titleView.setTextColor(Color.BLUE)
                }
                else -> {
                    titleView.setTypeface(null, Typeface.BOLD)
                    titleView.setTextColor(textColour)
                }
            }
        }

        fun eventBind(txt : String?){
            titleView.apply {
                text = "・${txt}"
                setTypeface(null, Typeface.NORMAL)
                setTextColor(textColour)
            }
        }
    }

    private fun getDaysInMonth(year: Int, month: Int): Int {
        val calendar = Calendar.getInstance().apply {
            set(year, month, 1)
        }
        return calendar.getActualMaximum(Calendar.DAY_OF_MONTH)
    }
    private fun daysInMonthArray(): ArrayList<String>? {
        val daysInMonthArray = ArrayList<String>()
        val year = calendar.get(Calendar.YEAR)
        val month = calendar.get(Calendar.MONTH)
        val daysInMonth = getDaysInMonth(year, month)
        val firstOfMonth = Calendar.getInstance().apply {
            set(year, month, 1)
        }
        val dayOfWeek = firstOfMonth.get(Calendar.DAY_OF_WEEK)

        // 앞당기기 위해 공백을 추가합니다.
        for (i in 1 until dayOfWeek) {
            daysInMonthArray.add("")
        }

        // 실제 날짜를 추가합니다.
        for (i in 1..daysInMonth) {
            daysInMonthArray.add(i.toString())
        }

        // RecyclerView에 표시될 총 셀 수를 42로 맞추기 위해 나머지 공백을 추가합니다.
        val totalCells = 42
        while (daysInMonthArray.size < totalCells) {
            daysInMonthArray.add("")
        }

        return daysInMonthArray
    }
    private fun previousMonthAction() {
        calendar.add(Calendar.MONTH, -1)
        calendarAdapter.updateList(daysInMonthArray())
        currentMonthTextView.text = " ${calendar.get(Calendar.YEAR)}년 ${calendar.get(Calendar.MONTH) + 1}월 "
    }
    private fun nextMonthAction() {
        calendar.add(Calendar.MONTH, 1)
        calendarAdapter.updateList(daysInMonthArray())
        currentMonthTextView.text = " ${calendar.get(Calendar.YEAR)}년 ${calendar.get(Calendar.MONTH) + 1}월 "
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
    private val eventAdapter = EventAdapter()

    private var clickListener : (Date) -> Unit? = {}
    fun setOnClick(click : (Date) -> Unit?){ clickListener = click }
    val dateFormat = SimpleDateFormat("yyyy-MM-dd")
    private val scheduleList : HashMap<Date?, List<String>?> = hashMapOf(
        dateFormat.parse("2024-3-6") to listOf("Meeting 1", "Meeting 2", "Appointment"),
        dateFormat.parse("2024-3-7") to listOf("Gym", "Lunch with friends"),
        dateFormat.parse("2024-3-8") to listOf("Shopping", "Dinner with family"),
        dateFormat.parse("2024-3-9") to listOf("Workout", "Movie night")
    )
    fun setSchedule(schedule : HashMap<Date, List<String>?>) {

    }
    inner class CalendarAdapter : RecyclerView.Adapter<CalendarViewHolder>(){
        private var daysList : ArrayList<String> = arrayListOf<String>()
        fun updateList(newItems : List<String>?){
            try{
                val oldList = daysList
                val newList = newItems ?: arrayListOf()
                val diffResult = DiffUtil.calculateDiff(StringDiffUtil(oldList, newList))
                diffResult.dispatchUpdatesTo(this@CalendarAdapter) // 이 부분이 수정되었습니다.
                daysList.clear()
                daysList.addAll(newItems ?: arrayListOf())
                Log.d("mDebug", "JuYeonCalendar, CalendarAdapter, updateList // updateList success")
            }catch (e:Exception){
                Log.e("mException", "JuYeonCalendar, CalendarAdapter, updateList // Exception : ${e.message}")
            }
        }
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CalendarViewHolder {
            var textviewDay = TextView(context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                gravity = Gravity.START
                textSize = 16f
            }
            val eventRecyclerView = RecyclerView(context).apply {
                layoutParams = LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT
                )
                adapter = eventAdapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(context).apply{
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                setItemViewCacheSize(0)
            }
            val dayView = LinearLayout(context).apply {
                orientation = VERTICAL
                gravity = Gravity.TOP
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    50.dpToPx(context)
                )

                background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE
                    setStroke(1.dpToPx(context), textColour) // 테두리 두께와 색상 설정
                }

                addView(textviewDay)
                addView(eventRecyclerView)
            }
            return CalendarViewHolder(dayView)
        }
        override fun onBindViewHolder(holder: CalendarViewHolder, position: Int) {
            when(daysList[position]){
                "" -> {
                    holder.bind(null, null, null)
                    holder.itemView.visibility = GONE
                }
                else -> {
                    val year = calendar.get(Calendar.YEAR)
                    val month = calendar.get(Calendar.MONTH) + 1
                    val mDate = dateFormat.parse("${year}-${month}-${daysList[position]}")
                    scheduleList.forEach {
                        if (it.key == mDate){
                            holder.bind(mDate, daysList[position], it.value)
                        }else{
                            holder.bind(null, daysList[position], null)
                        }
                    }
                    holder.itemView.visibility = VISIBLE
                }
            }
        }
        override fun getItemCount() = daysList.size
//        override fun onViewRecycled(holder: CalendarViewHolder) {
//            try{
//                super.onViewRecycled(holder)
//                holder.let {
//                    it.bind("")
//                }
//            }catch (e:Exception){
//                Log.e("mException", "CalendarAdapter, onViewRecycled // Exception : ${e.message}")
//            }
//        }
    }
    inner class EventAdapter : RecyclerView.Adapter<TextViewHolder>(){
        private var mList : ArrayList<String> = arrayListOf<String>()
        fun updateList(newItems : List<String>?){
            try{
                val oldList = mList
                val newList = newItems ?: arrayListOf()
                val diffResult = DiffUtil.calculateDiff(StringDiffUtil(oldList, newList))
                diffResult.dispatchUpdatesTo(this@EventAdapter) // 이 부분이 수정되었습니다.
                mList.clear()
                mList.addAll(newItems ?: arrayListOf())
                Log.d("mDebug", "JuYeonCalendar, EventAdapter, updateList // updateList success")
            }catch (e:Exception){
                Log.e("mException", "JuYeonCalendar, EventAdapter, updateList // Exception : ${e.message}")
            }
        }
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TextViewHolder {
            // TextView를 생성하고 레이아웃 파라미터를 설정합니다.
            val weekTitleView = TextView(context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                gravity = Gravity.START
                textSize = 10f
                maxLines = 1
                ellipsize = TextUtils.TruncateAt.END
            }
            return TextViewHolder(weekTitleView)
        }
        override fun getItemCount(): Int = mList.size
        override fun onBindViewHolder(holder: TextViewHolder, position: Int) {
            holder.eventBind(mList[position])
        }
        override fun onViewRecycled(holder: TextViewHolder) {
            try{
                super.onViewRecycled(holder)
                holder.let {
                    it.eventBind(null)
                }
            }catch (e:Exception){
                Log.e("mException", "EventAdapter, onViewRecycled // Exception : ${e.message}")
            }
        }
    }
    inner class CalendarViewHolder(itemView: LinearLayout) : ViewHolder(itemView) {
        val backgroundView = itemView
        val dayTitleView = itemView.getChildAt(0) as TextView
        val eventListView = itemView.getChildAt(1) as RecyclerView

        fun bind(date: Date?, day : String?, schedule : List<String>?) {

//            var mYear : Int = 0
//            var mMonth : Int = 0
//            var mDay : Int = 0
//            if (date != null){
//                calendar.time = date
//                mMonth = calendar.get(Calendar.MONTH) + 1
//                mDay = calendar.get(Calendar.DAY_OF_MONTH)
//                mYear = calendar.get(Calendar.YEAR)
//
//                val mDate = dateFormat.parse("${mYear}-${mMonth}-${mDay}")
//                val list = scheduleList[mDate]
//                eventAdapter.updateList(list)
//            }
            if (date != null && schedule != null){
                eventAdapter.updateList(schedule)
                dayTitleView.apply {
                    setOnClickListener {
                        Log.e("mException", "dayTitleView, schedule : ${schedule} // date: ${date}")
                    }
                    setTextColor(textColour)
                }
                itemView.setOnClickListener {
                    Log.e("mException", "itemView, schedule : ${schedule} // date: ${date}")

                }
            }


            dayTitleView.apply {
                text = " ${day}"
            }
        }
    }

}