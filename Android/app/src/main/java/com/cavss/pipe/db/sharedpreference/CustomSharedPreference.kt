package com.cavss.pipe.db.sharedpreference

import android.content.Context
import android.content.SharedPreferences
import org.json.JSONObject

object CustomSharedPreference {
    private const val PREFS_NAME = "CustomSharedPreference"
    private var sharedPreferences: SharedPreferences? = null

    fun init(context: Context) {
        sharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    }

    fun writeMemo(memo : String){
        sharedPreferences?.edit()?.putString("memo", memo)?.apply()
    }

    fun readMemo() : String {
        return sharedPreferences?.getString("memo","") ?: ""
    }

    fun updateInformationCountry(country : String){
        sharedPreferences?.edit()?.putString("informationCountry", country)?.apply()
    }
    fun readInformationCountry() : String {
        return sharedPreferences?.getString("informationCountry", "") ?: ""
    }

    fun setValue(key: String, value: Any) {
        sharedPreferences?.edit()?.apply {
            when (value) {
                is String -> putString(key, value)
                is Int -> putInt(key, value)
                is Long -> putLong(key, value)
                is Float -> putFloat(key, value)
                is Boolean -> putBoolean(key, value)
                else -> throw IllegalArgumentException("Unsupported value type")
            }
            apply()
        }
    }

    fun <T : Any> getValue(key: String, defaultValue: T): T {
        return when (defaultValue) {
            is String -> sharedPreferences?.getString(key, defaultValue) as T
            is Int -> sharedPreferences?.getInt(key, defaultValue) as T
            is Long -> sharedPreferences?.getLong(key, defaultValue) as T
            is Float -> sharedPreferences?.getFloat(key, defaultValue) as T
            is Boolean -> sharedPreferences?.getBoolean(key, defaultValue) as T
            else -> throw IllegalArgumentException("Unsupported value type")
        }
    }

    fun removeValue(key: String) {
        sharedPreferences?.edit()?.remove(key)?.apply()
    }

    fun deleteSharedPreferences() {
        sharedPreferences?.edit()?.clear()?.apply()
    }
}

