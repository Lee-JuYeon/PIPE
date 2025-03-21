package com.cavss.pipe.model.money.bank.savingProducts

import com.google.gson.annotations.SerializedName

// 적금
data class SavingsProductResult(
    @SerializedName("prdt_div")
    val prdt_div : String,

    @SerializedName("total_count")
    val total_count : Int,

    @SerializedName("max_page_no")
    val max_page_no : Int,

    @SerializedName("now_page_no")
    val now_page_no : Int,

    @SerializedName("err_cd")
    val err_cd : String,

    @SerializedName("err_msg")
    val err_msg : String,

    @SerializedName("baseList")
    val baseList : List<SavingProductModel>,

    @SerializedName("optionList")
    val optionList : List<SavingProductOptionModel>,

    ) {
}