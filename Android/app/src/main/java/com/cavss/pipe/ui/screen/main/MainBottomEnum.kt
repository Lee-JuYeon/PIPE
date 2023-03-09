package com.cavss.pipe.ui.screen.main

enum class MainBottomEnum(val rawValue : String) {
    MY("MY"),
    MONEY("MONEY"),
    PLACE("PLACE"),
    JOB("JOB");

    override fun toString(): String {
        return rawValue
    }
}