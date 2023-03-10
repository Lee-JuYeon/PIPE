package com.cavss.pipe.ui.screen.main.place.frags
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.pipe.databinding.FragmentPlaceOfficeBinding

class OfficeFragment : Fragment() {

    private lateinit var binding : FragmentPlaceOfficeBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentPlaceOfficeBinding.inflate(inflater, container, false)
        return binding.root
    }
}