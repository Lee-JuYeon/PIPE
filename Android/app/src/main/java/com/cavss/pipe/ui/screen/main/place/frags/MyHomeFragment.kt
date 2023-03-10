package com.cavss.pipe.ui.screen.main.place.frags

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.pipe.databinding.FragmentPlaceMyhomeBinding

class MyHomeFragment : Fragment() {

    private lateinit var binding : FragmentPlaceMyhomeBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentPlaceMyhomeBinding.inflate(inflater, container, false)
        return binding.root
    }
}