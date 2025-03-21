package com.cavss.pipe.model.money.bank.savingProducts

import com.google.gson.annotations.SerializedName

// 적금
data class SavingProductModel(
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

    @SerializedName("mtrt_int")
    val mtrt_int : String?,

    @SerializedName("spcl_cnd")
    val spcl_cnd : String?,

    @SerializedName("join_deny")
    val join_deny : String?,

    @SerializedName("join_member")
    val join_member : String?,

    @SerializedName("etc_note")
    val etc_note : String?,

    @SerializedName("max_limit")
    val max_limit : Int,

    @SerializedName("dcls_strt_day")
    val dcls_strt_day : String?,

    @SerializedName("dcls_end_day")
    val dcls_end_day : String?,

    @SerializedName("fin_co_subm_day")
    val fin_co_subm_day : String?
) {
}