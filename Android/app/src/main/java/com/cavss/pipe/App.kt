package com.cavss.pipe

import android.app.Application
import com.cavss.pipe.util.secure.AESHelper
import com.cavss.pipe.util.secure.ZygoteInit


class App : Application() {
    init {
        INSTANCE = this
    }

    // 여기다 코드 추가. 다른곳에 할 경우, 스래드 오류발생
    override fun onCreate() {
        super.onCreate()
        ZygoteInit.warmUpJcaProviders()
        AESHelper.keystoreSetting()
    }

    companion object {
        lateinit var INSTANCE: App
    }
}