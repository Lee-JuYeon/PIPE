package com.cavss.pipe.model.target

enum class StartUpState(val rawValue : String) {
    PreStartUp("예비창업자"),
    InBusiness("영업중"),
    StrugglingFinancially("생계곤란"),
    ClosingDownSoon("폐업예정자"),
    NA("해당사항없음")
}