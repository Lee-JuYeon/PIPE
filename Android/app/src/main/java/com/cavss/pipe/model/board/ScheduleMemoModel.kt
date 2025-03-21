package com.cavss.pipe.model.board

data class ScheduleMemoModel(
    val originalUID : String,
    val title : String,
    val content : String,
    val date : HashMap<String, String>
) {
    fun toHashmap() : HashMap<String, String>{
        return hashMapOf(
            "uid" to originalUID,
            "title" to title,
            "content" to content,
            "startDate" to date["start"].toString(),
            "endDate" to date["end"].toString()
        )
    }

    override fun toString(): String {
        return super.toString()
    }
}