package com.cavss.pipe.model.money.bank.depositProducts

import com.google.gson.annotations.SerializedName

// 정기예금
data class DepositProductOptionModel(
    @SerializedName("dcls_month")
    val dcls_month : String,            // 공시 제출월 [YYYYMM]

    @SerializedName("fin_co_no")
    val fin_co_no : String,              // 금융회사 코드

    @SerializedName("fin_prdt_cd")
    val fin_prdt_cd : String,            // 금융상품 코드

    @SerializedName("intr_rate_type")
    val intr_rate_type : String,        // 저축 금리 유형

    @SerializedName("intr_rate_type_nm")
    val intr_rate_type_nm : String,     // 저축 금리 유형명

    @SerializedName("save_trm")
    val save_trm : String,              // 저축 기간 [단위: 개월]

    @SerializedName("intr_rate")
    val intr_rate : Float,              // 저축 금리 [소수점 2자리]

    @SerializedName("intr_rate2")
    val intr_rate2 : Float              // 최고 우대금리 [소수점 2자리]
)