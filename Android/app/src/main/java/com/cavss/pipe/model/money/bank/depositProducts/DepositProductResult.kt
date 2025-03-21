package com.cavss.pipe.model.money.bank.depositProducts

import com.google.gson.annotations.SerializedName

// 정기예금
data class DepositProductResult (
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
    var baseList: MutableList<DepositProductModel>,

    @SerializedName("optionList")
    var optionList: MutableList<DepositProductOptionModel>
)