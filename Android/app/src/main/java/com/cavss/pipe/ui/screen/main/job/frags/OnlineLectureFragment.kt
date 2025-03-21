package com.cavss.pipe.ui.screen.main.job.frags

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.cavss.pipe.databinding.FragmentJobLectureBinding
import com.cavss.pipe.databinding.FragmentPlaceTicketBinding
import com.cavss.pipe.vm.PipeVM

class OnlineLectureFragment : Fragment(){

    private val pipeVM : PipeVM by activityViewModels()
    private lateinit var binding : FragmentJobLectureBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobLectureBinding.inflate(inflater, container, false)
        return binding.root
    }
}