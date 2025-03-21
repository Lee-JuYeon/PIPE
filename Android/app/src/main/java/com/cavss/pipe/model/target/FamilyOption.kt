package com.cavss.pipe.model.target

enum class FamilyOption(val rawValue : String) {
    MultiChildFamily("다자녀가구"),
    HomelessHouseHold("무주택세대"),
    Newcomer("신규전입"),
    ExtendedFamily("확대가족"),
    MulticulturalFamily("다문화가족"),
    NothKoreanDefector("북한이탈주민"),
    SingleParentFamily("한부모가정"),
    GrandparentFamily("조손가정"),
    OnePersonFamily("1인가구"),
    NA("해당사항없음")
}