package com.cavss.pipe.ui.screen.main

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class MainBottomNaviVM : ViewModel() {

    private val fragmentType = MutableLiveData<MainBottomEnum>(MainBottomEnum.BOARD)
    fun setFragmentType(type : MainBottomEnum){ fragmentType.postValue(type) }
    val getFragmentType : LiveData<MainBottomEnum>
        get() = fragmentType


    init {
        setFragmentType(MainBottomEnum.BOARD)
    }
}