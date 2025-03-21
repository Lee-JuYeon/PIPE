package com.cavss.pipe.ui.screen.main.money.frags

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
import com.cavss.pipe.databinding.FragmentMoneyBankBinding
import com.cavss.pipe.databinding.HolderMoneyBankBinding
import com.cavss.pipe.model.money.bank.depositProducts.FixedDepositDTO
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.PipeVM

class BankFragment : Fragment() {

    private lateinit var binding : FragmentMoneyBankBinding
    private val pipeVM : PipeVM by activityViewModels()
    private var adapter : BaseAdapters.RecyclerAdapter<FixedDepositDTO, HolderMoneyBankBinding>? = null
    private fun setRecyclerview(recyclerview : RecyclerView){
        try {
            val clickEvent = object : IClickListener<FixedDepositDTO> {
                override fun onItemClick(model: FixedDepositDTO, position: Int) {
                    Log.e("mException", "clicked : ${model}")
                }
            }

            adapter = object : BaseAdapters.RecyclerAdapter<FixedDepositDTO, HolderMoneyBankBinding>(){
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_money_bank
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: FixedDepositDTO?
                ): List<Pair<Int, Any>> {
                    return listOf(
                        BR.model to model!!,
                        BR.position to position,
                        BR.clickCallback to clickEvent
                    )
                }
            }

            recyclerview.apply {
                adapter = adapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(requireActivity()).apply{
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }
        }catch (e:Exception){
            Log.e("mException", "BankFragment, setRecyclerview // Exception : ${e.localizedMessage}")
        }
    }
    private fun updateFixedDepositAdapter(newList : List<FixedDepositDTO>){
        try {
            adapter?.updateList(newList)
        }catch (e:Exception){
            Log.e("mException", "BankFragment, updateAdapterList // Exception : ${e.localizedMessage}")
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentMoneyBankBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setRecyclerview(recyclerview = binding.recyclerview)
    }

    override fun onStart() {
        super.onStart()
        pipeVM.let {
//            it.loadBankFixedDepositList()
//            it.loadBankSavingsList()
//            it.loadBankPensionSavingList()
//            it.bankFixedDepositList.observe(requireActivity()){ list : List<FixedDepositDTO> ->
//                updateFixedDepositAdapter(list)
//            }
//            it.bankSavingList.observe(requireActivity()){ list : List<SavingsDTO> ->
//
//            }
//            it.bankPensionSavingList.observe(requireActivity()){ list : List<PensionSavingsDTO> ->
//
//            }
        }
    }
}