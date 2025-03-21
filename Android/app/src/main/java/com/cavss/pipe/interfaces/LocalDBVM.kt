package com.cavss.pipe.interfaces
//
//import android.app.Application
//import androidx.lifecycle.*
//import com.cavss.pipe.db.localdb.LocalDB
//import com.cavss.pipe.model.my.MemoModel
//
//class LocalDBVM(application: Application) : AndroidViewModel(application) {
//    private val db : LocalDB = LocalDB.setInstance(application.applicationContext)
//
//    suspend fun getMemos(): LiveData<MemoModel> {
//        return db.memoDAO().getMemos()
//    }
//
//    suspend fun updateMemo(newMemo : HashMap<String, ByteArray>){
//        db.memoDAO().updateMemo(newMemo = newMemo)
//    }
//
//
//    override fun onCleared() {
//        super.onCleared()
//        LocalDB.destroyDataBase()
//    }
//
//    init {
//        LocalDB.setInstance(application)
//        val memoDAO = LocalDB.getDB().memoDAO()
//
//    }
//}


/*

        configuration = Configuration.getInstance()

 private var configuration : IConfigurationProvider? = null
    fun setMapViewInit(){
        try{
            val applicationContext = getApplication<Application>().applicationContext
            // Configuration 객체 설정
            val cacheSize = 25 * 1024 * 1024 // 25MB
            configuration?.tileFileSystemCacheMaxBytes = cacheSize.toLong()
            configuration?.load(applicationContext, PreferenceManager.getDefaultSharedPreferences(applicationContext))

//            mapView.let {
//                it.setTileSource(org.osmdroid.tileprovider.tilesource.TileSourceFactory.MAPNIK)
//                it.setMultiTouchControls(true)
//                cameraPosition = it.controller
//                cameraPosition?.setZoom(14.0)
//            }
        }catch (e:Exception){
            Log.e("mException", "LocalDBVM, setMapVeiwInit // Exception : ${e.localizedMessage}")
        }
    }
 */