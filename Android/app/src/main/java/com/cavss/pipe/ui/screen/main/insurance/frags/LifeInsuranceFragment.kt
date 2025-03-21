package com.cavss.pipe.ui.screen.main.insurance.frags

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentInsuranceLifeBinding
import com.cavss.pipe.model.job.certification.CheckBoxModel
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.PipeVM

class LifeInsuranceFragment : Fragment() {

    private lateinit var binding : FragmentInsuranceLifeBinding
    private val pipeVM : PipeVM by activityViewModels()
//    private var fixedDepositAdapter : BaseAdapters.RecyclerAdapter<FixedDepositDTO, HolderFixeddepositBinding>? = null
//    private fun setItemRecyclerview(recyclerview : RecyclerView){
//        try {
//            val clickEvent = object : IClickListener<FixedDepositDTO> {
//                override fun onItemClick(model: FixedDepositDTO, position: Int) {
//                    Log.e("mException", "clicked : ${model}")
//                }
//            }
//
//            fixedDepositAdapter = object : BaseAdapters.RecyclerAdapter<FixedDepositDTO, HolderFixeddepositBinding>(){
//                override fun setViewHolderXmlFileName(viewType: Int): Int {
//                    return R.layout.holder_fixeddeposit
//                }
//
//                override fun setViewHolderVariable(
//                    position: Int,
//                    model: FixedDepositDTO?
//                ): List<Pair<Int, Any>> {
//                    return listOf(
//                        BR.model to model!!,
//                        BR.position to position,
//                        BR.clickCallback to clickEvent
//                    )
//                }
//            }
//
//            recyclerview.apply {
//                adapter = fixedDepositAdapter
//                setHasFixedSize(true)
//                layoutManager = LinearLayoutManager(requireActivity()).apply{
//                    orientation = LinearLayoutManager.VERTICAL
//                    isItemPrefetchEnabled = false
//                }
//                addItemDecoration(CustomItemGap(10))
//                setItemViewCacheSize(0)
//            }
//        }catch (e:Exception){
//            Log.e("mException", "FinanceBankFragment, setItemRecyclerview // Exception : ${e.localizedMessage}")
//        }
//    }
//    private fun updateFixedDepositAdapter(newList : List<FixedDepositDTO>){
//        try {
//            fixedDepositAdapter?.updateList(newList)
//        }catch (e:Exception){
//            Log.e("mException", "FinanceBankFragment, updateAdapterList // Exception : ${e.localizedMessage}")
//        }
//    }
//
//    private var loanAdapter : LoanAdapter<Any>? = null
//    private fun setItemRecyclerview(recyclerview: RecyclerView){
//        try{
//            val clickEvent = object : IClickListener<Any> {
//                override fun onItemClick(model: Any, position: Int) {
//                    Log.e("mException", "clicked : ${model}")
//                }
//            }
//            loanAdapter = LoanAdapter<Any>()
//            loanAdapter?.setClickListener(clickEvent)
//            recyclerview.apply {
//                adapter = loanAdapter
//                setHasFixedSize(true)
//                layoutManager = LinearLayoutManager(requireActivity()).apply{
//                    orientation = LinearLayoutManager.VERTICAL
//                    isItemPrefetchEnabled = false
//                }
//                setItemViewCacheSize(0)
//            }
//        }catch (e:Exception){
//            Log.e("mException", "FinanceLoanFragment, setItemRecyclerview // Exception : ${e.localizedMessage}")
//        }
//    }
//
//    private var checkboxAdapter : BaseAdapters.RecyclerAdapter<CheckBoxModel, HolderCheckboxBinding>? = null
//    private fun setCheckBoxRecyclerview(recyclerview : RecyclerView){
//        try {
//            val clickEvent = object : IClickListener<CheckBoxModel> {
//                override fun onItemClick(model: CheckBoxModel, position: Int) {
//                    Log.e("mException", "clicked : ${model}")
//                }
//            }
//
//            checkboxAdapter = object : BaseAdapters.RecyclerAdapter<CheckBoxModel, HolderCheckboxBinding>(){
//                override fun setViewHolderXmlFileName(viewType: Int): Int {
//                    return R.layout.holder_checkbox
//                }
//
//                override fun setViewHolderVariable(
//                    position: Int,
//                    model: CheckBoxModel?
//                ): List<Pair<Int, Any>> {
//                    return listOf(
//                        BR.model to model!!,
//                        BR.position to position,
//                        BR.clickCallback to clickEvent
//                    )
//                }
//            }
//
//            recyclerview.apply {
//                adapter = checkboxAdapter
//                setHasFixedSize(true)
//                layoutManager = LinearLayoutManager(requireActivity()).apply{
//                    orientation = LinearLayoutManager.HORIZONTAL
//                    isItemPrefetchEnabled = false
//                }
//                setItemViewCacheSize(0)
//            }
//        }catch (e:Exception){
//            Log.e("mException", "FinanceLoanFragment, setCheckBoxRecyclerview // Exception : ${e.localizedMessage}")
//        }
//    }
//    private fun updateCheckboxAdapter(newList : List<CheckBoxModel>){
//        try {
//            checkboxAdapter?.updateList(newList)
//        }catch (e:Exception){
//            Log.e("mException", "FinanceLoanFragment, updateCheckboxAdapter // Exception : ${e.localizedMessage}")
//        }
//    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentInsuranceLifeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }

    override fun onStart() {
        super.onStart()
        pipeVM.let {
//            it.loadLoanList()
//            it.loanList.observe(requireActivity()){ list : List<Any> ->
//                loanAdapter?.updateList(list)
//            }
        }
    }
}