package com.cavss.pipe.ui.screen.main.job.frags

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentJobEmploymentBinding
import com.cavss.pipe.databinding.HolderEmploymentBinding
import com.cavss.pipe.model.job.employment.EmploymentModel
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.PipeVM

class EmploymentFragment : Fragment() {

    private lateinit var binding: FragmentJobEmploymentBinding
    private val pipeVM: PipeVM by activityViewModels()

    private var customAdapter: BaseAdapters.RecyclerAdapter<EmploymentModel, HolderEmploymentBinding>? =
        null

    private fun setRecyclerview(recyclerview: RecyclerView) {
        try {
            val clickEvent = object : IClickListener<EmploymentModel> {
                override fun onItemClick(model: EmploymentModel, position: Int) {
                    Log.e("mException", "clicked : ${model}")
                }
            }

            customAdapter =
                object : BaseAdapters.RecyclerAdapter<EmploymentModel, HolderEmploymentBinding>() {
                    override fun setViewHolderXmlFileName(viewType: Int): Int {
                        return R.layout.holder_employment
                    }

                    override fun setViewHolderVariable(
                        position: Int,
                        model: EmploymentModel?
                    ): List<Pair<Int, Any>> {
                        return listOf(
                            BR.model to model!!,
                            BR.position to position,
                            BR.clickCallback to clickEvent
                        )
                    }
                }

            recyclerview.apply {
                adapter = customAdapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(requireActivity()).apply {
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }
        } catch (e: Exception) {
            Log.e(
                "mException",
                "EmploymentFragment, setRecyclerview // Exception : ${e.localizedMessage}"
            )
        }
    }

    private fun updateAdapterList(newList: List<EmploymentModel>) {
        try {
            customAdapter?.updateList(newList)
        } catch (e: Exception) {
            Log.e("mException", "EmploymentFragment, updateAdapterList // Exception : ${e.localizedMessage}")
        }
    }
    private fun setDialog(textView: TextView){
        try{

        }catch (e:Exception){
            Log.e("mException", "EmploymentFragment, setDialog // Exception : ${e.localizedMessage}")
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentJobEmploymentBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setRecyclerview(binding.employmentRecyclerview)
    }

    override fun onStart() {
        super.onStart()
        pipeVM.let {
            it.loadJobEmploymentList()
            it.jobEmploymentList.observe(this){ list : List<EmploymentModel> ->
                updateAdapterList(list)
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        customAdapter = null
    }
}
