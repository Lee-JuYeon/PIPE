package com.cavss.pipe.api.retrofit

import com.cavss.pipe.BuildConfig
import com.cavss.pipe.model.money.bank.depositProducts.DepositProductResponse
import com.cavss.pipe.model.money.bank.savingProducts.SavingProductResponse
import com.cavss.pipe.model.money.bank.annuitySavingProducts.AnnuitySavingProductResponse
import com.cavss.pipe.api.opendata.model.job.certification.korea.date.CertificationKrDateResponseDTO
import com.cavss.pipe.api.opendata.model.job.certification.korea.name.CertificationKrNameResponseDTO
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query
import java.util.Calendar

interface IRetrofit {

    @GET("depositProductsSearch.json")
    suspend fun getBankDepositProductList(
        @Query("auth") auth : String,
        @Query("topFinGrpNo") topFinGrpNo : String,
        @Query("pageNo") pageNo : Int,
    ): Response<DepositProductResponse>

    @GET("savingProductsSearch.json")
    suspend fun getBankSavingProductList(
        @Query("auth") auth : String,
        @Query("topFinGrpNo") topFinGrpNo : String,
        @Query("pageNo") pageNo : Int,
    ): Response<SavingProductResponse>

    @GET("annuitySavingProductsSearch.json")
    suspend fun getBankAnnuitySavingProductList(
        @Query("auth") auth : String,
        @Query("topFinGrpNo") topFinGrpNo : String,
        @Query("pageNo") pageNo : Int,
    ): Response<AnnuitySavingProductResponse>

    @GET(BuildConfig.api_get_kr_certification_name)
    suspend fun getCertificationKrNameList(
        @Query("serviceKey") serviceKey : String
    ): CertificationKrNameResponseDTO


    @GET(BuildConfig.api_get_kr_certification_date)
    suspend fun getCertificationKrDateList(
        @Query("serviceKey") serviceKey : String,
        @Query("numOfRows") numOfRows : String? = "50",
        @Query("pageNo") pageNo : String? = "1",
        @Query("dataFormat") dataFormat : String? = "xml",
        @Query("implYy") implYy : String? = "2024",
        @Query("qualgbCd") qualgbCd : String = "T", // T : 국가기술자격 - C : 과정평가형자격 - W : 일학습병행자격 - S : 국가전문자격
        @Query("jmCd") jmCd : String = "0740"
    ): CertificationKrDateResponseDTO
}

