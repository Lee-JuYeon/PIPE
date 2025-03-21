package com.cavss.pipe.ui.screen.main.place.frags

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.preference.PreferenceManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BuildConfig
import com.cavss.pipe.databinding.FragmentPlaceOfficeBinding
//import com.cavss.pipe.vm.LocalDBVM
import com.cavss.pipe.vm.PipeVM
import org.osmdroid.api.IMapController
import org.osmdroid.config.Configuration
import org.osmdroid.util.GeoPoint
import org.osmdroid.views.MapView
import org.osmdroid.views.overlay.Marker

class OfficeFragment : Fragment() {

    private lateinit var binding : FragmentPlaceOfficeBinding
    private val pipeVM : PipeVM by activityViewModels()
//    private val localDBVM : LocalDBVM by activityViewModels()

    private var cameraPosition : IMapController? = null
    private fun moveCameraPosition(geo : GeoPoint){
        cameraPosition?.setCenter(geo)
    }
    private fun setMapView(mapView : MapView){
        try{
            Configuration.getInstance().let {
                it.userAgentValue = BuildConfig.APPLICATION_ID
                val cacheSize = 25 * 1024 * 1024 // 25MB
                it.tileFileSystemCacheMaxBytes = cacheSize.toLong()
                it.load(requireContext(), PreferenceManager.getDefaultSharedPreferences(requireContext()))
            }

            mapView.let {
                it.setTileSource(org.osmdroid.tileprovider.tilesource.TileSourceFactory.DEFAULT_TILE_SOURCE)
                it.setMultiTouchControls(true)
                cameraPosition = it.controller
                cameraPosition?.setZoom(14.0)
            }

            // 서울 중심 좌표
            val seoulLocation = GeoPoint(37.5665, 126.9780)
            moveCameraPosition(seoulLocation)

            // 핀 추가
            val seoulMarker = Marker(mapView)
            seoulMarker.position = seoulLocation
            seoulMarker.title = "서울"
            seoulMarker.setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM)
            mapView.overlays.add(seoulMarker)

            // 도쿄 핀 생성
            val tokyoLocation = GeoPoint(35.6895, 139.6917) // 도쿄의 위도, 경도
            val tokyoMarker = Marker(mapView)
            tokyoMarker.position = tokyoLocation
            tokyoMarker.title = "도쿄"
            mapView.overlays.add(tokyoMarker)

            // 뉴욕 핀 생성
            val newYorkLocation = GeoPoint(40.7128, -74.0060) // 뉴욕의 위도, 경도
            val newYorkMarker = Marker(mapView)
            newYorkMarker.position = newYorkLocation
            newYorkMarker.title = "뉴욕"
            mapView.overlays.add(newYorkMarker)

//            // 타일 캐시 관리
//            val tileCache = TileCacheProvider(context).tileCache  // 캐시 객체 생성
//            val tileSource = TileSourceFactory.DEFAULT_TILE_SOURCE // 타일 소스 설정
//            val mapTileProvider = MapTileProviderBasic(context.applicationContext, tileSource, tileCache)

        }catch (e:Exception){
            Log.e("mException", "OfficeFragment, setMapView // Exception : ${e.localizedMessage}")
        }
    }
    private fun setRecyclerview(recyclerView: RecyclerView){
        try{

        }catch (e:Exception){
            Log.e("mException", "OfficeFragment, setRecycerlview // Exception : ${e.localizedMessage}")
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentPlaceOfficeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setMapView(binding.officeMap)
        setRecyclerview(binding.officeRecyclerview)
    }

    override fun onStart() {
        super.onStart()

        pipeVM.let {
//            it.loadJobCertificationList()
//            it.jobCertificationList.observe(this){ list : List<CertificationModel> ->
//                updateAdapterList(list)
//            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        binding.officeMap.apply {
            tileProvider.clearTileCache()
            overlays.clear()
        }
    }
}