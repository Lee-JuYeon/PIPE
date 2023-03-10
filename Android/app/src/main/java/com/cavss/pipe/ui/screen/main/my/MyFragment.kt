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

    private var customCalendarView : CustomCalendarView? = null
    private fun setCustomViews(){
        customCalendarView = CustomCalendarView()
        customCalendarView?.setCalenderView(binding.myCalendar, requireContext())
    }

    private lateinit var binding : FragmentMyBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentMyBinding.inflate(inflater, container, false)
        binding.run {
            setCustomViews()
        }
        return binding.root
    }




    override fun onStart() {
        super.onStart()
    }

    override fun onResume() {
        super.onResume()
    }

    override fun onPause() {
        super.onPause()
    }


    override fun onStop() {
        super.onStop()
    }

    override fun onDestroyView() {
        super.onDestroyView()
    }

}