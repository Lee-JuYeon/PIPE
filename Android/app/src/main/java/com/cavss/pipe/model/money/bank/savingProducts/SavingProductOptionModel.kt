package com.cavss.pipe.model.money.bank.savingProducts

import com.google.gson.annotations.SerializedName

// 적금
data class SavingProductOptionModel(
    @SerializedName("dcls_month")
    val dcls_month : String,

    @SerializedName("fin_co_no")
    val fin_co_no : String,

    @SerializedName("fin_prdt_cd")
    val fin_prdt_cd : String,

    @SerializedName("intr_rate_type")
    val intr_rate_type : String,

    @SerializedName("intr_rate_type_nm")
    val intr_rate_type_nm : String,

    @SerializedName("rsrv_type")
    val rsrv_type : String,

    @SerializedName("rsrv_type_nm")
    val rsrv_type_nm : String,

    @SerializedName("save_trm")
    val save_trm : String,

    @SerializedName("intr_rate")
    val intr_rate : Float,

    @SerializedName("intr_rate2")
    val intr_rate2 : Float
) {
}