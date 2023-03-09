package com.cavss.pipe.ui.custom.calendar

import android.content.Context
import android.graphics.Color
import android.util.Log
import android.view.Gravity
import android.view.ViewGroup
import android.widget.CalendarView
import android.widget.TextView
import com.cavss.pipe.R
import java.util.*

class CustomCalendarView {

    fun setCalenderView (calendar: CalendarView, context: Context){
        try{
            setWeekendColour(calendar)
            setAddEvents(calendar, context)
        }catch (e:Exception){
            Log.e("mException", "CustomCalendarView, setCalenderView // Exception : ${e.localizedMessage}")
        }
    }

    private fun setWeekendColour(calendar: CalendarView){
        try{
            calendar.setOnDateChangeListener { _, year, month, dayOfMonth ->
                val calendarInstance = Calendar.getInstance()
                calendarInstance.set(year, month, dayOfMonth)

                val dayOfWeek = calendarInstance.get(Calendar.DAY_OF_WEEK)

                // 토요일(7)이면 파란색, 일요일(1)이면 빨간색
                when (dayOfWeek) {
                    Calendar.SATURDAY -> {
                        calendar.dateTextAppearance = R.style.CalendarView_Saturday
                    }
                    Calendar.SUNDAY -> {
                        calendar.dateTextAppearance = R.style.CalendarView_Sunday
                    }
                    else -> {
                        calendar.dateTextAppearance = R.style.CalendarView_Default
                    }
                }
            }
        }catch (e:Exception){
            Log.e("mException", "CustomCalendarView, setWeekendColour // Exception : ${e.localizedMessage}")
        }
    }

    private fun setAddEvents(calendar: CalendarView, context : Context){
        try{
            calendar.setOnDateChangeListener { view, year, month, dayOfMonth ->
                if (month == 2 && dayOfMonth == 23) { // 선택된 날짜가 4/23인 경우
                    val dayPickerView = (calendar.getChildAt(0) as ViewGroup).getChildAt(dayOfMonth - 1)

                    // 새로운 TextView 생성
                    val textView1 = TextView(context).apply {
//                    id = View.generateViewId()
                        text = "일정 1"
                        gravity = Gravity.CENTER
                        layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                        setTextColor(Color.WHITE)
                        setBackgroundColor(Color.YELLOW)
                    }
                    val textView2 = TextView(context).apply {
//                    id = View.generateViewId()
                        text = "일정 2"
                        gravity = Gravity.CENTER
                        layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                        setTextColor(Color.WHITE)
                        setBackgroundColor(Color.CYAN)
                    }
                    val textView3 = TextView(context).apply {
//                    id = View.generateViewId()
                        text = "일정 3"
                        gravity = Gravity.CENTER
                        layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                        setTextColor(Color.WHITE)
                        setBackgroundColor(Color.MAGENTA)
                    }
                    val textView4 = TextView(context).apply {
//                    id = View.generateViewId()
                        text = "일정 4"
                        gravity = Gravity.CENTER
                        layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                        setTextColor(Color.WHITE)
                        setBackgroundColor(Color.GREEN)
                    }

                    (dayPickerView as ViewGroup).addView(textView1)
                    (dayPickerView as ViewGroup).addView(textView2)
                    (dayPickerView as ViewGroup).addView(textView3)
                    (dayPickerView as ViewGroup).addView(textView4)
                }
            }
        }catch (e:Exception){
            Log.e("mException","CustomCalendarView, setAddEvents // Exception : ${e.localizedMessage}")
        }
    }
}