package com.cavss.pipe.api.retrofit

import com.cavss.pipe.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.converter.simplexml.SimpleXmlConverterFactory
import java.util.concurrent.TimeUnit

object RetrofitManager {
    var builder : Retrofit.Builder? = null
    init {
        builder = Retrofit.Builder()
    }
    private val okHttpClient = OkHttpClient.Builder()
        .addInterceptor(HttpLoggingInterceptor().apply {
            level = HttpLoggingInterceptor.Level.BODY
        })
        .connectTimeout(30, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .build()

    private fun getClientByJson(baseURL : String) : Retrofit = builder!!
        .baseUrl(baseURL)
        .addConverterFactory(GsonConverterFactory.create())
        // 위에서 설정한 클라이언트로 retrofit2 클라이언트를 설정한다.
        .client(okHttpClient)
        .build()

    private fun getClientByXML(baseURL : String) : Retrofit = builder!!
        .baseUrl(baseURL)
        .addConverterFactory(SimpleXmlConverterFactory.create())
//        .client(okHttpClient)
        .build()

    fun getCertificationKrNamesClient() : IRetrofit = getClientByXML(BuildConfig.api_url_kr_certification_name).create(IRetrofit::class.java)
    fun getCertificationKrDateClient() : IRetrofit = getClientByXML(BuildConfig.api_url_kr_certification_date).create(IRetrofit::class.java)

//    fun getBankClient() : IRetrofit = getClientByJson(BuildConfig.api_baseurld_bank).create(IRetrofit::class.java)
//    fun getCertificationDateClient() : IRetrofit = getClientByJson(BuildConfig.api_baseurl_certification_date).create(IRetrofit::class.java)
//    fun getCertificationNameClient() : IRetrofit = getClientByXML(BuildConfig.api_baseurl_certification_name).create(IRetrofit::class.java)
//    fun getMyHomeSeoulMZClient() : IRetrofit = getClientByJson(BuildConfig.api_baseurl_myhome_seoulmz).create(IRetrofit::class.java)
//    fun getContestClient() : IRetrofit = getClientByXMLTest(BuildConfig.api_baseurl_contest).create(IRetrofit::class.java)
}
