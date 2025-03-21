package com.cavss.pipe.api.opendata

import android.util.Log
import com.cavss.pipe.BuildConfig
import com.cavss.pipe.api.opendata.model.job.certification.korea.date.CertificationKrDateItemDTO
import com.cavss.pipe.api.retrofit.RetrofitManager
import retrofit2.Retrofit
import java.util.Calendar

object OpenDataAPI {
    suspend fun getBank(){
        try {
            // 응답 처리
        } catch (e: Exception) {
            println("API 호출 중 오류 발생: ${e.message}")
        }
    }

    suspend fun getJobCertificationKOREA() : List<CertificationKrDateItemDTO> {
        val list = mutableListOf<CertificationKrDateItemDTO>()
        try {
            val responseName = RetrofitManager.getCertificationKrNamesClient().getCertificationKrNameList(BuildConfig.api_key_publicdata)
            val listName = responseName.body?.items?.itemList
            listName?.forEach {
                val currentYear = Calendar.getInstance().get(Calendar.YEAR).toString()
                val responseDate = RetrofitManager.getCertificationKrDateClient().getCertificationKrDateList(
                    serviceKey = BuildConfig.api_key_publicdata,
                    dataFormat = "xml",
                    implYy = currentYear,
                    qualgbCd = it.qualgbcd ?: "T", // 자격증 구분 코드
                    jmCd = it.jmcd ?: "0740" // 자격증코드
                )
                responseDate.body?.items?.forEach {
                    list.add(it)
                }
//                responseDate.body?.items?.items?.forEach {
//                    list.add(it)
//                }
            }
        } catch (e: Exception) {
            Log.e("mException","OpenDataAPI, getJobCertificationKOREA // Exception : ${e.message}")
            list.clear()
        }
        return list
    }
}