package com.cavss.pipe.model.money.bank.savingProducts

// 적금
data class PensionSavingsDTO(
    val dcls_month : String?, // 공시 제출월 [YYYYMM]
    val bankName : String?, // 금융회사 명
    val productName : String?, // 금융 상품명
    val join_way : String?, // 가입 방법
    val pnsn_kind : String?, // 연금종류
    val pnsn_kind_nm : String?, // 연금종류명
    val sale_strt_day : String?, // 판매 개시일
    val mntn_cnt : Long, // 유지건수[단위: 건] 또는 설정액 [단위: 원]
    val prdt_type : String?, // 상품유형
    val prdt_type_nm : String?, // 상품유형명
    val avg_prft_rate : Double,
    val dcls_rate : Double, // 공시이율 [소수점 2자리]
    val guar_rate : String?, // 최저 보증이율
    val btrm_prft_rate_1 : Double, // 과거 수익률1(전년도) [소수점 2자리]
    val btrm_prft_rate_2 : Double, // 과거 수익률2(전전년도) [소수점 2자리]
    val btrm_prft_rate_3 : Double, // 과거 수익률3(전전전년도) [소수점 2자리]
    val etc : String?, // 기타사항
    val sale_co : String?, // 판매사
    val dcls_strt_day : String?, // 공시 시작일
    val dcls_end_day : String?, // 공시 종료일
    val fin_co_subm_day : String?, // 금융회사 제출일 [YYYYMMDDHH24MI]
    val option : MutableList<SavingProductOptionModel> // 이자율
)