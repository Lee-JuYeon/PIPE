package com.cavss.pipe.ui.screen.main.job.frags

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.api.opendata.OpenDataAPI
import com.cavss.pipe.api.opendata.model.job.certification.korea.date.CertificationKrDateItemDTO
import com.cavss.pipe.databinding.FragmentJobCertificationBinding
import com.cavss.pipe.databinding.HolderCertificationBinding
import com.cavss.pipe.db.sharedpreference.CustomSharedPreference
import com.cavss.pipe.model.job.certification.CertificationModel
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.PipeVM
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class CertificationFragment : Fragment(){

    private lateinit var binding : FragmentJobCertificationBinding
    private val pipeVM : PipeVM by activityViewModels()
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobCertificationBinding.inflate(inflater, container, false)
        return binding.root
    }

    private var certificationKoreaAdapter : BaseAdapters.RecyclerAdapter<CertificationKrDateItemDTO, HolderCertificationBinding>? = null
    private fun setCertificationRecyclerview(recyclerView : RecyclerView) {
        try {
            val clickEvent = object : IClickListener<CertificationKrDateItemDTO> {
                override fun onItemClick(model: CertificationKrDateItemDTO, position: Int) {
                    Log.e("mException", "해당 아이템 저장 : ${model}")

                }
            }
            certificationKoreaAdapter = object :
                BaseAdapters.RecyclerAdapter<CertificationKrDateItemDTO, HolderCertificationBinding>() {
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_certification
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: CertificationKrDateItemDTO?
                ): List<Pair<Int, Any>> {
                    return listOf(
                        BR.model to model!!,
                        BR.position to position,
                        BR.clickCallback to clickEvent
                    )
                }

            }
            recyclerView.apply {
                adapter = certificationKoreaAdapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(requireActivity()).apply {
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }
        } catch (e: Exception) {
            Log.e("mException", "CertificationFragment, setCertificationRecyclerview // Exception : ${e.localizedMessage}")
        }
    }
    private fun setEdittext(edittext : EditText){
        try{
            edittext.addTextChangedListener {
                val inputString = it.toString()
            }
        }catch (e:Exception){
            Log.e("mException","CertificationFragment, setEdittext // Exception : ${e.localizedMessage}")
        }
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setEdittext(binding.certificationSearch)
        setCertificationRecyclerview(binding.certificationRecyclerview)
    }

    override fun onStart() {
        super.onStart()
        GlobalScope.launch(Dispatchers.IO) {
            try {
                val countryCode = CustomSharedPreference.readInformationCountry()
                when(countryCode){
                    "korea" -> {
                        try {
                            val list = OpenDataAPI.getJobCertificationKOREA()
                            certificationKoreaAdapter?.updateList(list)
                        }catch (e:Exception){
                            Log.e("mException", "CertificationFragment, onStart, korea, certificationKoreaAdapter // Exception : ${e.localizedMessage}")
                        }
                    }
                    "spain" -> {
//                        try {
//                            val list = OpenDataAPI.getJobCertificationKOREA()
//                            certificationKoreaAdapter?.updateList(list)
//                        }catch (e:Exception){
//                            Log.e("mException", "CertificationFragment, onStart, korea, certificationKoreaAdapter // Exception : ${e.localizedMessage}")
//                        }
                    }
                    "australia" -> {
//                        try {
//                            val list = OpenDataAPI.getJobCertificationKOREA()
//                            certificationKoreaAdapter?.updateList(list)
//                        }catch (e:Exception){
//                            Log.e("mException", "CertificationFragment, onStart, korea, certificationKoreaAdapter // Exception : ${e.localizedMessage}")
//                        }
                    }
                    "italy" -> {
//                        try {
//                            val list = OpenDataAPI.getJobCertificationKOREA()
//                            certificationKoreaAdapter?.updateList(list)
//                        }catch (e:Exception){
//                            Log.e("mException", "CertificationFragment, onStart, korea, certificationKoreaAdapter // Exception : ${e.localizedMessage}")
//                        }
                    }
                    "indonesia" -> {
//                        try {
//                            val list = OpenDataAPI.getJobCertificationKOREA()
//                            certificationKoreaAdapter?.updateList(list)
//                        }catch (e:Exception){
//                            Log.e("mException", "CertificationFragment, onStart, korea, certificationKoreaAdapter // Exception : ${e.localizedMessage}")
//                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("mException", "CertificationFragment, onStart, coroutine, certificationKoreaAdapter // Exception : ${e.localizedMessage}")
            }
        }
        pipeVM.let {
//            it.loadJobCertificationList()
//            it.jobCertificationList.observe(this){ list : List<CertificationModel> ->
//                updateCertificationAdapterList(list)
//            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        certificationKoreaAdapter = null
    }
}