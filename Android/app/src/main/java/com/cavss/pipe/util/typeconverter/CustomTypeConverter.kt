package com.cavss.pipe.util.typeconverter

import android.content.Context
import android.util.Base64
import android.util.TypedValue
import androidx.room.TypeConverter
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlin.collections.HashMap

object CustomTypeConverter {

    @TypeConverter
    @JvmStatic
    fun hashMapToString(map: HashMap<String, ByteArray>): String {
        return Gson().toJson(map)
    }

    @TypeConverter
    @JvmStatic
    fun stringToHashMap(value: String): HashMap<String, ByteArray> {
        val type = object : TypeToken<HashMap<String, ByteArray>>() {}.type
        return Gson().fromJson(value, type)
    }


    @TypeConverter
    @JvmStatic
    fun listToString(value: ArrayList<String>) : String {
        val type = object : TypeToken<ArrayList<String>>() {}.type
        return Gson().toJson(value, type)
    }

    @TypeConverter
    @JvmStatic
    fun stringToList(value: String) : ArrayList<String>{
        val type = object : TypeToken<ArrayList<String>>() {}.type
        return Gson().fromJson(value, type)
    }
}
//fun String.toHashMapAES() : HashMap<String, ByteArray>{
//    val parts = this.split(",")
//    val iv = Base64.decode(parts[0], Base64.DEFAULT)
//    val encrypted = Base64.decode(parts[1], Base64.DEFAULT)
//    val map = HashMap<String, ByteArray>()
//    map["iv"] = iv
//    map["encrypted"] = encrypted
//    return map
//}
//
//fun HashMap<String, ByteArray>.toStringAES(): String {
//    val iv = Base64.encodeToString(this["iv"], Base64.DEFAULT)
//    val encrypted = Base64.encodeToString(this["encrypted"], Base64.DEFAULT)
//    return "$iv,$encrypted"
//}
//
fun Int.dpToPx(context : Context): Int {
    return TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        this.toFloat(),
        context.resources.displayMetrics
    ).toInt()
}