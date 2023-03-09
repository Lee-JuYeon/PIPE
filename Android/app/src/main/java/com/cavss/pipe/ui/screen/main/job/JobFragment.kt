package com.cavss.pipe.ui.screen.main.job

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.pipe.databinding.FragmentJobBinding

class JobFragment: Fragment(){

    private lateinit var binding : FragmentJobBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobBinding.inflate(inflater, container, false)
        return binding.root
    }
}