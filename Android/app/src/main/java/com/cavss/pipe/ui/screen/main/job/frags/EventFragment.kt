package com.cavss.pipe.ui.screen.main.job.frags

import android.content.Intent
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import coil.Coil
import coil.request.ImageRequest
import coil.request.ImageResult
import coil.size.Scale
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentJobEventBinding
import com.cavss.pipe.databinding.FragmentPlaceTicketBinding
import com.cavss.pipe.databinding.HolderJobfairBinding
import com.cavss.pipe.model.job.jobfair.JobfairModel
import com.cavss.pipe.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.ui.custom.simmer.ShimmerDrawable
import com.cavss.pipe.vm.PipeVM
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class EventFragment : Fragment(){

    private val pipeVM : PipeVM by activityViewModels()
    private lateinit var binding : FragmentJobEventBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobEventBinding.inflate(inflater, container, false)
        return binding.root
    }
}