package com.cavss.pipe.ui.screen.main.my

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CalendarView
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentMyBinding
import com.cavss.pipe.ui.custom.calendar.CustomCalendarView
import java.util.Calendar

class MyFragment : Fragment() {

    private lateinit var binding : FragmentMyBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentMyBinding.inflate(inflater, container, false)
        return binding.root
    }


    private var customCalendarView : CustomCalendarView? = null
    private fun setCustomViews(){
        customCalendarView = CustomCalendarView()
        customCalendarView?.setCalenderView(binding.myCalendar, requireContext())
    }


    override fun onStart() {
        super.onStart()
        Log.d("mDebug", "MyFragment 상태 : onStart")
    }

    override fun onResume() {
        super.onResume()
        Log.d("mDebug", "MyFragment 상태 : onResume")
    }

    override fun onPause() {
        super.onPause()
        Log.d("mDebug", "MyFragment 상태 : onPause")
//        Log.d("mDebug", "다른 프래그먼트로 넘어가면 호출됨")
    }


    override fun onStop() {
        super.onStop()
        Log.d("mDebug", "MyFragment 상태 : onStop")
//        Log.d("mDebug", "다른 프래그먼트로 넘어가면 호출됨")
    }

    override fun onDestroyView() {
        super.onDestroyView()
        Log.d("mDebug", "MyFragment 상태 : onDestroyView")
//        Log.d("mDebug", "다른 프래그먼트로 넘어가면 호출됨")
    }

}