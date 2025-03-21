package com.cavss.pipe.model.target

enum class BirthState(val rawValue : String) {
    PARENTS_TO_BE("예비부모"),
    INFERTILITY("난임"),
    EXPECTING_MOTHER("임신부"),
    BIRTH("출산"),
    ADOPTION("입양"),
    NA("해당사항없음")
}
