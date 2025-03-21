package com.cavss.pipe.model.place.office

data class OfficeModel (
    var companyTitle : String?,                 // 기관명, 운영기관
    var centerTitle : String?,                  // 센터명
    var mainContents : String?,                 // 주력분야
    var address : String?,                      // wnth
    var contact : Map<String, String>?,         // 연락처
    var equipmentInventory : List<String>?,     // 보유장비 현황, 부대시설
    var geo : Map<String, String>?,             // 위도 경
    var applyNotify : String?,                  // 입주기업 특이사항
    var applyProcessGuid : String?,             // 입주기업 선정방법
    var term : String?,                         // 공고후 선정까지의 기간
    var applyPeriod : Map<String, String>?,     // 신청기간, 접수기간
    var worktime : Map<String, String>?,        // 이용시간, 업무시간
    var target : String?,                       // 지원대상
    var price : Map<String, String>?,           // 비용
    var maxiumPopulation : Int,                 // 수용인원
    var officeType : String?,                    // 공간유형
    var caution : List<String>?                 // 주의사항
)
