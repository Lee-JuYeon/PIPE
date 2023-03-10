package com.cavss.pipe.ui.screen.main.job.frags

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.pipe.databinding.FragmentJobEmploymentBinding

class EmploymentFragment : Fragment(){

    private lateinit var binding : FragmentJobEmploymentBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobEmploymentBinding.inflate(inflater, container, false)
        return binding.root
    }
}