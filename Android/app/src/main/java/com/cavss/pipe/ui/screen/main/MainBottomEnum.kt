package com.cavss.pipe.ui.screen.main

enum class MainBottomEnum(val rawValue : String) {
    BOARD("Board"),
    MONEY("MONEY"),
    PLACE("PLACE"),
//    INSURANCE("INSURANCE"),
    JOB("JOB");

    override fun toString(): String {
        return rawValue
    }
}