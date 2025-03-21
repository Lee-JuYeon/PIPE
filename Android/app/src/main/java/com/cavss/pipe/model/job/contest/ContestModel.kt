package com.cavss.pipe.model.job.contest

data class ContestModel (
    var contestTitle : String?,         // 공모전 이름       v s
    var contestSubject : String?,       // 주제            v s
    var target : String?,               // 모집대상         v s
    var size : String?,                 // 규모
    var mainContent : String?,          // 주요내용             s
    var reward : Map<String, String>?,  // 시상. 지원내용    v
    var applyPeriod : Map<String, String>?, // 접수기간     v
    var serviceCall : Map<String, String>?, // 문의
    var companyTitle : String?,             // 기관 명
    var applyRequirement : String?,         // 지원 자격        s
    var howToApply : String?,               // 지원 방법
    var address : String?,                  // 지역
    var contestHomePage : String?,          // 공모 홈페이지
    var exceptionTarget : String?           // 제외 대상
)
