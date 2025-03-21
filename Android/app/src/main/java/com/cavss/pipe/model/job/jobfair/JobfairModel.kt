package com.cavss.pipe.model.job.jobfair

data class JobfairModel(
    val period : Map<String, String>?,  // 행사기간
    val time : String?,                 // 행사시간
    val address : String?,              // 행사장소
    val companyListAndJobInfo : String?,// 참여기업,구인정보
    val contact : Map<String, String>?, // 문의처
    val url : String?,
    val additionalInfo : List<String>?, // 부대사항
    val postImage : String?             // 포스터이미지

)