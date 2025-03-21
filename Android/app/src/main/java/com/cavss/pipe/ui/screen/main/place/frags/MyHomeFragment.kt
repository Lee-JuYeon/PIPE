package com.cavss.pipe.ui.screen.main.place.frags

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
import com.cavss.pipe.databinding.FragmentPlaceMyhomeBinding
import com.cavss.pipe.databinding.HolderMyhomeBinding
import com.cavss.pipe.model.place.home.myhome.MyHomeModel
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.PipeVM

class MyHomeFragment : Fragment() {

    private lateinit var binding : FragmentPlaceMyhomeBinding
    private val pipeVM : PipeVM by activityViewModels()

    private var customAdapter : BaseAdapters.RecyclerAdapter<MyHomeModel, HolderMyhomeBinding>? = null
    private fun setRecyclerview(recyclerview : RecyclerView){
        try {
            val clickEvent = object : IClickListener<MyHomeModel>{
                override fun onItemClick(model: MyHomeModel, position: Int) {
                    Log.e("mException", "clicked : ${model}")
                }
            }

            customAdapter = object : BaseAdapters.RecyclerAdapter<MyHomeModel, HolderMyhomeBinding>(){
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_myhome
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: MyHomeModel?
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
                layoutManager = LinearLayoutManager(requireActivity()).apply{
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }
        }catch (e:Exception){
            Log.e("mException", "MyHomeFragment, setRecyclerview // Exception : ${e.localizedMessage}")
        }
    }
    private fun updateAdapterList(newList : List<MyHomeModel>){
        try {
            customAdapter?.updateList(newList)
        }catch (e:Exception){
            Log.e("mException", "MyHomeFragment, updateAdapterList // Exception : ${e.localizedMessage}")
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentPlaceMyhomeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setRecyclerview(recyclerview = binding.myhomeRecyclerview)
    }

    override fun onStart() {
        super.onStart()
        pipeVM.let {
//            it.loadMyHomeSeoulMZList(
//                page = 1,
//                perPage = 100
//            )
//            it.myHomeSeoulMZList.observe(requireActivity()){
//                updateAdapterList(it)
//            }
        }
//        binding.myhomeRecyclerview.let {
//            it.addOnScrollListener(object : RecyclerView.OnScrollListener() {
//                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
//                    super.onScrolled(recyclerView, dx, dy)
//
//                    val layoutManager = recyclerView.layoutManager as LinearLayoutManager
//                    val visibleItemCount = layoutManager.childCount // 현재 화면에 보이는 아이템 수
//                    val totalItemCount = layoutManager.itemCount // 전체 아이템수
//
//                    // 리사이클러뷰에서 첫번째로 보이는 아이템의 위치
//                    val firstVisibleItemPosition = layoutManager.findFirstVisibleItemPosition()
//
//                    if (visibleItemCount + firstVisibleItemPosition >= totalItemCount
//                        && firstVisibleItemPosition >= 0
//                    ) {
//                        // RecyclerView가 끝까지 스크롤되었음을 감지했습니다.
//                        // 여기에서 추가 아이템을 로드하면 됩니다.
//                        pipeVM.myHomeSeoulMZpageAdd++
//                    }
//                }
//            })
//        }
    }

    override fun onDestroy() {
        super.onDestroy()
        customAdapter = null
    }

}