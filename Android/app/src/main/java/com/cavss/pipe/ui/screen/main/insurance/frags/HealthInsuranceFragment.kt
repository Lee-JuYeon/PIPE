package com.cavss.pipe.ui.screen.main.insurance.frags

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.cavss.pipe.databinding.FragmentInsuranceHealthBinding
import com.cavss.pipe.databinding.FragmentJobBootcampBinding
import com.cavss.pipe.vm.PipeVM

class HealthInsuranceFragment : Fragment() {
    private val pipeVM : PipeVM by activityViewModels()
    private lateinit var binding : FragmentInsuranceHealthBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentInsuranceHealthBinding.inflate(inflater, container, false)
        return binding.root
    }
}