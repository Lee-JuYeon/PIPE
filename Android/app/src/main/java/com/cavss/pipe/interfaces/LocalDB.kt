package com.cavss.pipe.interfaces

//import android.content.Context
//import androidx.room.*
//import androidx.sqlite.db.SupportSQLiteDatabase
//import com.cavss.pipe.dao.MemoDAO
//import com.cavss.pipe.model.my.MemoModel
//import com.cavss.pipe.util.secure.AESHelper
//import com.cavss.pipe.util.typeconverter.CustomTypeConverter
//import kotlinx.coroutines.CoroutineScope
//import kotlinx.coroutines.Dispatchers
//import kotlinx.coroutines.GlobalScope
//import kotlinx.coroutines.launch
//import java.util.concurrent.Executors
//
//@Database(
//    entities = [
//        MemoModel::class
//    ],
//    version = 1,
//    exportSchema = false
//)
//@TypeConverters(CustomTypeConverter::class)
//abstract class LocalDB : RoomDatabase() {
//    abstract fun memoDAO() : MemoDAO
//    companion object {
//        @Volatile
//        private var INSTANCE: LocalDB? = null
//        fun setInstance(_context: Context): LocalDB {
//            return INSTANCE ?: synchronized(this) {
//                INSTANCE ?: buildDatabase(_context).also { INSTANCE = it }
//            }
//        }
//
//        private var DB_name: String = "LocalDB"
//        private fun buildDatabase(_context: Context): LocalDB {
//            return Room.databaseBuilder(
//                _context,
//                LocalDB::class.java,
//                DB_name
//            )
//                .fallbackToDestructiveMigration()
//                .addCallback(object : RoomDatabase.Callback(){
//                    override fun onCreate(db: SupportSQLiteDatabase) {
//                        super.onCreate(db)
//                        // 데이터가 없을 경우, 인위적으로 초기 데이터를 생성
//                        Executors.newSingleThreadExecutor().execute {
//                            INSTANCE?.let {
//                                val encryptedMemo  = AESHelper.encrypt("test 111".toByteArray(Charsets.UTF_8))
//                                GlobalScope.launch(Dispatchers.IO) {
//                                    it.memoDAO().insertMemo(
//                                        MemoModel(
//                                            memo = encryptedMemo
//                                        )
//                                    )
//                                }
//                            }
//                        }
//                    }
//            }).build()
//        }
//
//        fun getDB(): LocalDB = INSTANCE!!
//
//        fun destroyDataBase(){
//            INSTANCE = null
//        }
//    }
//}

