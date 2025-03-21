package com.cavss.pipe.model.money.bank.depositProducts

import com.google.gson.annotations.SerializedName

// 정기예금
data class DepositProductModel(
    // 공시 제출월 [YYYYMM]
    @SerializedName("dcls_month")
    val dcls_month : String?,

    // 금융회사 코드
    @SerializedName("fin_co_no")
    val fin_co_no : String?,

    // 금융 상품 code
    @SerializedName("fin_prdt_cd")
    val fin_prdt_cd : String?,

    // 금융회사 title
    @SerializedName("kor_co_nm")
    val kor_co_nm : String?,

    // 금융 상품명
    @SerializedName("fin_prdt_nm")
    val fin_prdt_nm : String?,

    // 가입 방법
    @SerializedName("join_way")
    val join_way : String?,

    // 만기 후 이자율
    @SerializedName("mtrt_int")
    val mtrt_int : String?,

    // 우대조건
    @SerializedName("spcl_cnd")
    val spcl_cnd : String?,

    // 가입제한  Ex) 1:제한없음, 2:서민전용, 3:일부제한
    @SerializedName("join_deny")
    val join_deny : String?,

    // 가입대상
    @SerializedName("join_member")
    val join_member : String?,

    // 기타 유의사항
    @SerializedName("etc_note")
    val etc_note : String?,

    // 최고한도
    @SerializedName("max_limit")
    val max_limit : String?,

    // 공시 시작일
    @SerializedName("dcls_strt_day")
    val dcls_strt_day : String?,

    //공시 종료일
    @SerializedName("dcls_end_day")
    val dcls_end_day : String?,

    // 금융회사 제출일 [YYYYMMDDHH24MI]
    @SerializedName("fin_co_subm_day")
    val fin_co_subm_day : String?
)