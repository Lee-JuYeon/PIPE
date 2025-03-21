package com.cavss.pipe.interfaces

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.text.TextUtils
import android.util.AttributeSet
import android.util.Log
import android.view.*
import android.widget.*
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.R
import com.cavss.pipe.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.pipe.util.typeconverter.dpToPx
import java.text.SimpleDateFormat
import java.util.*

//data class Event(val date: Date, val description: String)
/*

 */
class CustomCalendarView(context: Context, attrs: AttributeSet?) : LinearLayout(context, attrs) {
    val calendarAdapter : CustomCalendarAdapter
    val calendar : Calendar
    val currentMonthTextView : TextView
    init {
        calendar = Calendar.getInstance()
        var currentMonth = calendar.get(Calendar.MONTH)
        calendarAdapter = CustomCalendarAdapter()

        // CustomCalendarView 클래스를 초기화합니다.
        orientation = VERTICAL
        gravity = Gravity.CENTER_HORIZONTAL
        val currentDate = calendar.time
        val yearMonthFormat = SimpleDateFormat("yyyy년 MM월", Locale.getDefault())
        val yearMonth = yearMonthFormat.format(currentDate)
        currentMonthTextView = TextView(context)
        currentMonthTextView.setTextColor(Color.BLACK)
        currentMonthTextView.textSize = 25f
        currentMonthTextView.text = " ${yearMonth} " // TODO: 현재 월 표시

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
            var mCurrentMont = --currentMonth
            if (mCurrentMont < 0){
                mCurrentMont = 0
                currentMonth = 0
            }
            calendarAdapter.updateCalendar(mCurrentMont)
            currentMonthTextView.text = " ${calendar.get(Calendar.YEAR)}년 ${mCurrentMont + 1}월 "
        }

        val nextMonthButton = TextView(context)
        nextMonthButton.text = "➡️"
        nextMonthButton.textSize = 25f
        nextMonthButton.setBackgroundColor(Color.TRANSPARENT)
        nextMonthButton.setOnClickListener {
            // TODO: 다음 달로 이동하는 기능 구현
            var mCurrentMont = ++currentMonth
            if (mCurrentMont > 11){
                mCurrentMont = 11
                currentMonth = 11
            }
            calendarAdapter.updateCalendar(mCurrentMont)
            currentMonthTextView.text = " ${calendar.get(Calendar.YEAR)}년 ${mCurrentMont + 1}월 "
        }


        topView.addView(prevMonthButton)
        topView.addView(currentMonthTextView)
        topView.addView(nextMonthButton)

        // 리사이클러뷰를 추가합니다.
        val calendarReycerlview = RecyclerView(context).apply {
            setHasFixedSize(true)
            setItemViewCacheSize(0)
            layoutParams = LayoutParams(
                LayoutParams.MATCH_PARENT,
                LayoutParams.WRAP_CONTENT
            )
            adapter = calendarAdapter.apply {
                updateCalendar(currentMonth)
            }
            layoutManager = object : GridLayoutManager(context, 7){
                override fun onLayoutCompleted(state: RecyclerView.State?) {
                    super.onLayoutCompleted(state)
                    for (i in 0 until childCount) {
                        val child = getChildAt(i)
                        val viewHolder = getChildViewHolder(child!!) as DayViewHolder

                        // get desired width and height of view
                        val parentWidth = this@apply.width // recyclerview의 너비 가져오기
                        val desiredWidth = parentWidth / 7 // recyclerview의 너비를 7로 나누어서 원하는 너비 계산
                        val desiredHeight = 50.dpToPx(context) // desired height of view

                        // set new layout params with desired width and height
                        val lp = viewHolder.itemView.layoutParams as GridLayoutManager.LayoutParams
                        lp.width = desiredWidth
                        lp.height = desiredHeight
                        viewHolder.backgroundView.layoutParams = lp
                    }
                }
            }.apply {
                isItemPrefetchEnabled = false
            }
        }

        // 상단 뷰와 리사이클러뷰를 CustomCalendarView에 추가합니다.
        addView(topView)
        addView(calendarReycerlview)
    }


    private var clickListener : (Date) -> Unit? = {}
    fun setOnClick(click : (Date) -> Unit?){
        clickListener = click
    }

    inner class CustomCalendarAdapter() : RecyclerView.Adapter<DayViewHolder>() {

        private var daysInMonth = mutableListOf<Date>()
        fun updateCalendar(currentMonth : Int){
            try{
                val newDaysInMonth = mutableListOf<Date>()
                // 해당 달의 시작일과 끝일을 계산합니다.
                calendar.set(Calendar.DAY_OF_MONTH, 1)
                var monthStartDate = calendar.time
//            calendar.set(Calendar.MONTH, currentMonth + 1)
                calendar.set(Calendar.MONTH, currentMonth )
                val monthEndDate = calendar.time

                // 첫번째 주 시작일을 구합니다.
                calendar.time = monthStartDate
                var firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)
                if (firstDayOfWeek == Calendar.SUNDAY) {
                    firstDayOfWeek = 1
                } else {
                    firstDayOfWeek -= 1
                }

                // 첫번째 주 시작일 이전의 빈 값을 추가합니다.
                for (i in 1 until firstDayOfWeek) {
                    newDaysInMonth.add(Date(0))
                }
                newDaysInMonth.add(Date(0))

                // 해당 달의 시작일부터 끝일까지의 Date 객체를 추가합니다.
                while (monthStartDate.before(monthEndDate)) {
                    newDaysInMonth.add(monthStartDate)
                    calendar.time = monthStartDate
                    calendar.add(Calendar.DAY_OF_MONTH, 1)
                    monthStartDate = calendar.time
                }

                val diffResult = DiffUtil.calculateDiff(
                    object : BaseDiffUtil<Date>(
                        oldList = daysInMonth,
                        newList = newDaysInMonth
                    ){},
                    false
                )

                diffResult.dispatchUpdatesTo(this)
                daysInMonth.clear()
                daysInMonth.addAll(newDaysInMonth ?: mutableListOf())
            }catch (e:Exception){
                Log.e("mException", "CustomCalendarAdapter , updateCalendar// Exception : ${e.message}")
            }
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DayViewHolder {
            var textviewDay = TextView(context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                gravity = Gravity.START
                textSize = 16f
            }

            // 리사이클러뷰를 추가합니다.
            val eventRecyclerView = RecyclerView(context).apply {
                layoutParams = LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    LayoutParams.WRAP_CONTENT
                )
                adapter
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
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    50.dpToPx(context)
                )

                addView(textviewDay)
                addView(eventRecyclerView)
            }

            return DayViewHolder(dayView)
        }
        override fun getItemCount(): Int {
            // 일자 리스트의 크기를 반환합니다.
            return daysInMonth.size
        }
        override fun onBindViewHolder(holder: DayViewHolder, position: Int) {
            // 각 아이템에 해당하는 일자를 설정합니다.
            val day = daysInMonth[position]

            if (day.time == 0L) {
                // 빈 뷰로 설정
                holder.itemView.visibility = View.INVISIBLE
            } else {
                // 날짜 표시
                holder.itemView.visibility = View.VISIBLE
                holder.bind(day, clickListener)
                holder.setRecyclerview(mapOf())
            }
        }
    }

    inner class DayViewHolder(itemView: LinearLayout) : RecyclerView.ViewHolder(itemView){
        private fun setShape(backgroundColour : Int) : GradientDrawable {
            val alpha = if (backgroundColour == Color.WHITE) 255 else 50
            val backgroundColor = Color.argb(alpha, Color.red(backgroundColour), Color.green(backgroundColour), Color.blue(backgroundColour))
            return GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                setColor(backgroundColor)
                setStroke(1, Color.BLACK)
            }
        }

        val backgroundView = itemView
        val dayTextView = itemView.getChildAt(0) as TextView
        val eventListView = itemView.getChildAt(1) as RecyclerView

        private var currentDay : String? = null
        fun setRecyclerview(events : Map<Date, String>){
            eventListView.apply {
                adapter = EventAdapter(events, currentDay ?: "")
            }
        }


        fun bind(day : Date, clickListener : (Date) -> Unit?){
            val numberday = SimpleDateFormat("d", Locale.getDefault()).format(day)
            val yearMonthDayFormat = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(day)
            val weekDay = SimpleDateFormat("EEE", Locale.getDefault()).format(day)
            dayTextView.text = if (yearMonthDayFormat == "1970-01-01") "" else numberday
            currentDay = yearMonthDayFormat
            backgroundView.setOnClickListener { clickListener(day) }

            when(weekDay){
                "토" -> {
                    backgroundView.background = setShape(backgroundColour = Color.BLUE)
                    dayTextView.setTextColor(Color.BLUE)
                }
                "일" -> {
                    backgroundView.background = setShape(backgroundColour = Color.RED)
                    dayTextView.setTextColor(Color.RED)
                }
                else -> {
                    backgroundView.background = setShape(backgroundColour = Color.WHITE)
                    dayTextView.setTextColor(context.getColor(R.color.black))
                }
            }
        }
    }

    inner class EventAdapter(private var events : Map<Date, String>, private var currentDay : String) : RecyclerView.Adapter<EventViewHolder>(){
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): EventViewHolder {
            val dayTextView = TextView(context).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE
                    setStroke(1.dpToPx(context), Color.BLACK) // 테두리 두께와 색상 설정
                }
                textSize = 10f
                gravity = Gravity.CENTER
                maxLines = 1
                ellipsize = TextUtils.TruncateAt.END
            }
            return EventViewHolder(dayTextView)
        }

        override fun getItemCount(): Int {
//            var format = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
//            var convertToDate = format.parse(currentDay)
//            return events.filterKeys { it == convertToDate }.count()
            return 0
        }

        override fun onBindViewHolder(holder: EventViewHolder, position: Int) {
//            var format = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
//            var convertToDate = format.parse(currentDay)
//            events.forEach { date, event ->
//                if (date == convertToDate){
//                    holder.bind(event)
//                }
//            }
            holder.bind("이벤트가 몇개나 있을까용")
        }
    }
    inner class EventViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        // 날짜를 표시하는 TextView
        private val dayTextView: TextView = itemView as TextView

        fun bind(eventText: String) {
            dayTextView.text = eventText
        }
    }
}


//class EventAdapter(private var events : Map<Date, String>, private var currentDay : String) : RecyclerView.Adapter<EventViewHolder>(){
//    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): EventViewHolder {
//        val dayTextView = TextView(context).apply {
//            layoutParams = ViewGroup.LayoutParams(
//                ViewGroup.LayoutParams.WRAP_CONTENT,
//                ViewGroup.LayoutParams.WRAP_CONTENT
//            )
//            background = GradientDrawable().apply {
//                shape = GradientDrawable.RECTANGLE
//                setStroke(1.dpToPx(), Color.BLACK) // 테두리 두께와 색상 설정
//            }
//            textSize = 10f
//            gravity = Gravity.CENTER
//            maxLines = 1
//            ellipsize = TextUtils.TruncateAt.END
//        }
//        return EventViewHolder(dayTextView)
//    }
//
//    override fun getItemCount(): Int {
////            var format = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
////            var convertToDate = format.parse(currentDay)
////            return events.filterKeys { it == convertToDate }.count()
//        return 0
//    }
//
//    override fun onBindViewHolder(holder: EventViewHolder, position: Int) {
////            var format = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
////            var convertToDate = format.parse(currentDay)
////            events.forEach { date, event ->
////                if (date == convertToDate){
////                    holder.bind(event)
////                }
////            }
//        holder.bind("이벤트가 몇개나 있을까용")
//    }
//}
//
//
//class EventViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
//    // 날짜를 표시하는 TextView
//    private val dayTextView: TextView = itemView as TextView
//
//    fun bind(eventText: String) {
//        dayTextView.text = eventText
//    }
//


//        // 달력에 표시될 일자 리스트입니다.
//        private val daysInMonth = mutableListOf<Date>()
//
//        init {
//            // 해당 달의 시작일과 끝일을 계산합니다.
//            val currentMonth = calendar.get(Calendar.MONTH) // 현재 월
//            calendar.set(Calendar.DAY_OF_MONTH, 1)
//            var monthStartDate = calendar.time
//            calendar.set(Calendar.MONTH, currentMonth + 1)
//            val monthEndDate = calendar.time
//
//            // 첫번째 주 시작일을 구합니다.
//            calendar.time = monthStartDate
//            var firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)
//            if (firstDayOfWeek == Calendar.SUNDAY) {
//                firstDayOfWeek = 1
//            } else {
//                firstDayOfWeek -= 1
//            }
//
//            // 첫번째 주 시작일 이전의 빈 값을 추가합니다.
//            for (i in 1 until firstDayOfWeek) {
//                daysInMonth.add(Date(0))
//            }
//            daysInMonth.add(Date(0))
//
//
//            // 해당 달의 시작일부터 끝일까지의 Date 객체를 추가합니다.
//            while (monthStartDate.before(monthEndDate)) {
//                daysInMonth.add(monthStartDate)
//                calendar.time = monthStartDate
//                calendar.add(Calendar.DAY_OF_MONTH, 1)
//                monthStartDate = calendar.time
//            }
//        }