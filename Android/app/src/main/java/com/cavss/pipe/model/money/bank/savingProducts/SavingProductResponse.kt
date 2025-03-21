package com.cavss.pipe.model.money.bank.savingProducts

import com.google.gson.annotations.SerializedName

// 적금
data class SavingProductResponse(
    @SerializedName("result")
    val result : SavingsProductResult
)