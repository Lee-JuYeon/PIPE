package com.cavss.pipe.model.money.bank.depositProducts

import com.google.gson.annotations.SerializedName

// 정기예금
data class DepositProductResponse(
    @SerializedName("result")
    val result : DepositProductResult
)