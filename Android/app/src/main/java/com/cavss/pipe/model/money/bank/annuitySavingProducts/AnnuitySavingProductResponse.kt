package com.cavss.pipe.model.money.bank.annuitySavingProducts

import com.google.gson.annotations.SerializedName

// 연금저축
data class AnnuitySavingProductResponse(
    @SerializedName("result")
    val result : AnnuitySavingProductResult
) {
}