package com.cavss.pipe.model.target

enum class IncomeState(val rawValue : String) {
    ZERO_FIFTY("0%-50%"),
    FIFTY_SEVENTYFIVE("51%-75%"),
    SEVENTYSIX_HUNDRED("76%-100%"),
    HUNDREDONE_TWOHUNDRED("101%-200%"),
    TWOHUNDRED_OVER("201%")
}