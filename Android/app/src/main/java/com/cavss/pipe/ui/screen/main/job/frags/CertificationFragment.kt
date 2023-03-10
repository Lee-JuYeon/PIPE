package com.cavss.pipe.ui.screen.main.job.frags

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.pipe.databinding.FragmentJobCertificationBinding

class CertificationFragment : Fragment(){

    private lateinit var binding : FragmentJobCertificationBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobCertificationBinding.inflate(inflater, container, false)
        return binding.root
    }
}