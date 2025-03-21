package com.cavss.pipe.ui.screen.main.board.frags

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentBoardNotificationBinding
import com.cavss.pipe.databinding.HolderNotificationBinding
import com.cavss.pipe.model.board.NotificationModel
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.NotificationVM
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.text.SimpleDateFormat

class NotificationFragment : Fragment() {

    // binding init
    private lateinit var binding : FragmentBoardNotificationBinding
    private val notificationVM : NotificationVM by activityViewModels()

    private var customAdapter : BaseAdapters.RecyclerAdapter<NotificationModel, HolderNotificationBinding>? = null
    private fun setRecyclerview(recyclerview : RecyclerView){
        try {
            // make instance of recyclerview holder click event
            val clickEvent = object : IClickListener<NotificationModel> {
                override fun onItemClick(model: NotificationModel, position: Int) {
                    Log.e("mException", "clicked : ${model}")
                }
            }

            // setting adapter of recyclerview
            customAdapter = object : BaseAdapters.RecyclerAdapter<NotificationModel, HolderNotificationBinding>(){
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_notification
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: NotificationModel?
                ): List<Pair<Int, Any>> {
                    return listOf(
                        BR.model to model!!, //
                        BR.position to position, // recyclerview viewholder position
                        BR.clickCallback to clickEvent // fetching recyclerview holder click event
                    )
                }
            }

            // setting recyclerview
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
            Log.e("mException", "NotificationFragment, setRecyclerview // Exception : ${e.localizedMessage}")
        }
    }
    private fun updateAdapterList(newList : List<NotificationModel>){
        try {
            // convert Notification Model's date(string) to Date type for sort by descending
            val convertedList = newList.toMutableList()
            convertedList.sortByDescending {
                val format = SimpleDateFormat("yyyy-MM-dd")
                val convertedDate = format.parse(it.date)
                convertedDate
            }
            customAdapter?.updateList(convertedList)
        }catch (e:Exception){
            Log.e("mException", "NotificationFragment : updateAdapterList // Exception : ${e.localizedMessage}")
        }
    }
    private fun notificationTitle(textview : TextView){
        try{
            textview.text = "📣 ${requireContext().resources.getString(R.string.fragment_board_item_notification)}"
            textview
        }catch (e:Exception){
            Log.e("mException", "NotificationFragment, notificationTitle // Exception : ${e.localizedMessage}")
        }
    }
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentBoardNotificationBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setRecyclerview(recyclerview = binding.recyclerview)
        notificationTitle(binding.title)
    }

    override fun onStart() {
        super.onStart()
        notificationVM.let { vm : NotificationVM ->
            vm.viewModelScope.launch(Dispatchers.IO) {
                // get notification data from VM
                vm.loadNotificationList()

                // update notification data from VM
                vm.notificationList.collect { value ->
                    updateAdapterList(value)
                }
            }
        }
    }
}