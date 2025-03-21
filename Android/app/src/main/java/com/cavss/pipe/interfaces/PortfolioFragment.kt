package com.cavss.pipe.interfaces

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.cavss.pipe.databinding.FragmentBoardPortfolioBinding
import com.cavss.pipe.vm.PipeVM

class PortfolioFragment : Fragment(){

    private lateinit var binding : FragmentBoardPortfolioBinding
    private val pipeVM : PipeVM by activityViewModels()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentBoardPortfolioBinding.inflate(inflater, container, false)
        return binding.root
    }

//    private var educationAdapter : HistoryA
    private fun setEducationRecyclerView(){

    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }

    override fun onStart() {
        super.onStart()
        pipeVM.let {
//            it.loadJobContestList()
//            it.jobContestList.observe(requireActivity()){ list : List<ContestModel> ->
//                updateAdapterList(list)
//            }
        }
    }
}