package com.cavss.pipe.model.money.bank.annuitySavingProducts

import com.google.gson.annotations.SerializedName

// 연금저축
data class AnnuitySavingProductModel(
    @SerializedName("dcls_month")
    val dcls_month : String?,

    @SerializedName("fin_co_no")
    val fin_co_no : String?,

    @SerializedName("fin_prdt_cd")
    val fin_prdt_cd : String?,

    @SerializedName("kor_co_nm")
    val kor_co_nm : String?,

    @SerializedName("fin_prdt_nm")
    val fin_prdt_nm : String?,

    @SerializedName("join_way")
    val join_way : String?,

    @SerializedName("pnsn_kind")
    val pnsn_kind : String?,

    @SerializedName("pnsn_kind_nm")
    val pnsn_kind_nm : String?,

    @SerializedName("sale_strt_day")
    val sale_strt_day : String?,

    @SerializedName("mntn_cnt")
    val mntn_cnt : Float,

    @SerializedName("prdt_type")
    val prdt_type : String?,

    @SerializedName("prdt_type_nm")
    val prdt_type_nm : String?,

    @SerializedName("avg_prft_rate")
    val avg_prft_rate : Float,

    @SerializedName("dcls_rate")
    val dcls_rate : String?,

    @SerializedName("guar_rate")
    val guar_rate : String?,

    @SerializedName("btrm_prft_rate_1")
    val btrm_prft_rate_1 : Float,

    @SerializedName("btrm_prft_rate_2")
    val btrm_prft_rate_2 : Float,

    @SerializedName("btrm_prft_rate_3")
    val btrm_prft_rate_3 : Float,

    @SerializedName("etc")
    val etc : String?,

    @SerializedName("sale_co")
    val sale_co : String?,

    @SerializedName("dcls_strt_day")
    val dcls_strt_day : String?,

    @SerializedName("dcls_end_day")
    val dcls_end_day : String?,

    @SerializedName("fin_co_subm_day")
    val fin_co_subm_day : String?

) {
}