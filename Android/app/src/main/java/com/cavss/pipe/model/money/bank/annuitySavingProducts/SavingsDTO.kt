package com.cavss.pipe.model.money.bank.annuitySavingProducts

// 연금저축
data class SavingsDTO(
    val dcls_month : String?, // 공시 제출월 [YYYYMM]
    val bankName : String?, // 은행명
    val productName : String?, // 상품 명
    val joinWay : String?, //가입 방법
    val mtrt_int : String?, // 만기 후 이자율
    val spcl_cnd : String?, // 우대조건,
    val join_deny : String?, //가입제한 Ex) 1:제한없음, 2:서민전용, 3:일부제한
    val join_member : String?, // 가입대상
    val etc_note : String?, // 기타 유의사항
    val max_limit : Long, // 최괴한도
    val dcls_strt_day : String?, // 공시 시작일
    val dcls_end_day : String?, // 공시 종료인
    val fin_co_subm_day : String?, // 금융회사 제출일 [YYYYMMDDHH24MI]
    val option : MutableList<AnnuitySavingProductOptionModel> // 이자율
)