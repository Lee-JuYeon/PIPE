package com.cavss.pipe.ui.screen.main.job.frags

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.pipe.databinding.FragmentJobJobfairBinding
class JobFairFragment : Fragment(){

    private lateinit var binding : FragmentJobJobfairBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobJobfairBinding.inflate(inflater, container, false)
        return binding.root
    }
}