package com.cavss.pipe.model.money.bank.annuitySavingProducts

import com.google.gson.annotations.SerializedName

// 연금저축
data class AnnuitySavingProductResult(
    @SerializedName("prdt_div")
    val prdt_div: String,

    @SerializedName("total_count")
    val total_count: Int,

    @SerializedName("max_page_no")
    val max_page_no: Int,

    @SerializedName("now_page_no")
    val now_page_no: Int,

    @SerializedName("err_cd")
    val err_cd: String,

    @SerializedName("err_msg")
    val err_msg: String,

    @SerializedName("baseList")
    var baseList: MutableList<AnnuitySavingProductModel>,

    @SerializedName("optionList")
    var optionList: MutableList<AnnuitySavingProductOptionModel>
) {
}