package com.cavss.pipe.abstracts

import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.cavss.pipe.databinding.HolderAdsGoogleBinding
import com.cavss.pipe.ui.custom.recyclerview.BaseDiffUtil
import com.google.android.gms.ads.AdRequest

abstract class AdsAdapter<MODEL : Any, BINDING : ViewDataBinding>(private val viewHolderLayout : Int) : RecyclerView.Adapter<ViewHolder>(){

    companion object {
        private const val VIEW_TYPE_CONTENT = 0
        private const val VIEW_TYPE_AD = 1
    }

    private val items = mutableListOf<MODEL>()
    fun updateList(newItems : List<MODEL>?){
        try{
            val updatedItems = mutableListOf<MODEL>()
            newItems?.forEachIndexed { index, item ->
                updatedItems.add(item)
                if (index != 0 && (index) % 3 == 0) {
                    val emptyModel = newItems.first() // 데이터는 있지만 더미모델임.
                    updatedItems.add(emptyModel)
                }
            }
            val diffResult = DiffUtil.calculateDiff(
                object : BaseDiffUtil<MODEL>(
                    oldList = items,
                    newList = updatedItems
                ){},
                false
            )
            items.clear()
            items.addAll(updatedItems)
            diffResult.dispatchUpdatesTo(this)
        }catch (e:Exception){
            Log.e("mException", "AdsAdapter, updateList // Exception : ${e.message}")
        }
    }

    abstract fun createContentViewHolder(binding: BINDING): ViewHolder
    abstract fun bindContentViewHolder(holder: ViewHolder, model : MODEL, position : Int)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = DataBindingUtil.inflate<BINDING>(inflater, viewHolderLayout, parent, false)
        return when (viewType) {
            VIEW_TYPE_CONTENT -> {
                createContentViewHolder(binding)
            }
            VIEW_TYPE_AD -> {
                val binding : HolderAdsGoogleBinding = HolderAdsGoogleBinding.inflate(inflater, parent, false)
                GoogleAdsViewHolder(binding)
            }
            else -> {
                createContentViewHolder(binding)
            }
        }
    }
    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        try{
            when(getItemViewType(position)){
                VIEW_TYPE_AD -> {
                    val mHolder = holder as AdsAdapter<*, *>.GoogleAdsViewHolder
                    mHolder.binding()
                }
                VIEW_TYPE_CONTENT -> {
                    bindContentViewHolder(holder, items[position], position)
                }
            }
        }catch (e:Exception){
            Log.e("mException", "AdsAdapter, onBindViewHolder // Exception : ${e.message}")
        }
    }

    override fun getItemCount() : Int {
        return items.size
    }
    override fun getItemViewType(position: Int): Int {
        return if (position != 0 && position % 4 == 0) VIEW_TYPE_AD else VIEW_TYPE_CONTENT
    }

    inner class GoogleAdsViewHolder(
        private val binding : HolderAdsGoogleBinding
    ) : RecyclerView.ViewHolder(binding.root){
        init {
            binding.adview.apply {
                val adRequest = AdRequest.Builder().build()
                loadAd(adRequest)
            }
        }
        fun binding(){
            try{
                binding.executePendingBindings()
            }catch (e:Exception){
                Log.e("mException", "AdsAdapter, GoogleAdsViewHolder // Exception : ${e.localizedMessage}")
            }
        }
    }
}