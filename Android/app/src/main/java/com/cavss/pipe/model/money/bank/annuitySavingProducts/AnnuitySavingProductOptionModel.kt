package com.cavss.pipe.model.money.bank.annuitySavingProducts

import com.google.gson.annotations.SerializedName

// 연금저축
data class AnnuitySavingProductOptionModel(

    @SerializedName("dcls_month")
    val dcls_month :String?,

    @SerializedName("fin_co_no")
    val fin_co_no : String?,

    @SerializedName("fin_prdt_cd")
    val fin_prdt_cd : String?,

    @SerializedName("pnsn_recp_trm")
    val pnsn_recp_trm : String?,

    @SerializedName("pnsn_recp_trm_nm")
    val pnsn_recp_trm_nm : String?,

    @SerializedName("pnsn_entr_age")
    val pnsn_entr_age : String?,

    @SerializedName("pnsn_entr_age_nm")
    val pnsn_entr_age_nm : String?,

    @SerializedName("mon_paym_atm")
    val mon_paym_atm : String?,

    @SerializedName("mon_paym_atm_nm")
    val mon_paym_atm_nm : String?,

    @SerializedName("paym_prd")
    val paym_prd : String?,

    @SerializedName("paym_prd_nm")
    val paym_prd_nm : String?,

    @SerializedName("pnsn_strt_age")
    val pnsn_strt_age : String?,

    @SerializedName("pnsn_strt_age_nm")
    val pnsn_strt_age_nm : String?,

    @SerializedName("pnsn_recp_amt")
    val pnsn_recp_amt : Float
) {
}