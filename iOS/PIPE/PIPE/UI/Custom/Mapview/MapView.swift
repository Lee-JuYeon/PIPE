//
//  MapView.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/07/20.
//

import Foundation
import UIKit
import MapKit

class MapView : UIView, MKMapViewDelegate {
    
    let reuseIdentifier = "pin"
    
    lazy var _map : MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setUI() {
        addSubview(_map)
        
        NSLayoutConstraint.activate([
            _map.topAnchor.constraint(equalTo: topAnchor),
            _map.leadingAnchor.constraint(equalTo: leadingAnchor),
            _map.trailingAnchor.constraint(equalTo: trailingAnchor),
            _map.bottomAnchor.constraint(equalTo: bottomAnchor) // 추가: 아래쪽 제약 조건
        ])
    }
    
    var _getMeterSize : Double?
    private func setMap(){
        _map.delegate = self
           
        // 지도의 초기 위치 설정
        let theGreatKingSeJong_latitude : Double = 37.572907
        let theGreatKingSeJong_longitude : Double = 126.976839
        let initialocation = CLLocationCoordinate2D(
            latitude: theGreatKingSeJong_latitude,
            longitude: theGreatKingSeJong_longitude
        ) // 샌프란시스코의 위도와 경도
       
        let region = MKCoordinateRegion(
            center: initialocation, // 지도 위치
            latitudinalMeters: CLLocationDistance(_getMeterSize ?? 1000),
            longitudinalMeters: CLLocationDistance(_getMeterSize ?? 1000)
        )
        _map.setRegion(region, animated: true) // 지도 영역 변경
    }
    
    func addMarkerPin(latitude : Double, longitude : Double, title : String, subTitle : String){
        // 추가로 마커 핀을 생성하여 추가할 수 있습니다.
        let anotherLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let markerPin = MKPointAnnotation()
        markerPin.coordinate = anotherLocation
        markerPin.title = title
        markerPin.subtitle = subTitle
        _map.addAnnotation(markerPin)
    }

    func moveCamera(setLatitude getLatitude : Double, setLongitude getLongitude : Double){
        let targetCoordinate = CLLocationCoordinate2D(
            latitude: getLatitude,
            longitude: getLongitude
        )
        let region = MKCoordinateRegion(
            center: targetCoordinate,
            latitudinalMeters: _getMeterSize ?? 1000,
            longitudinalMeters: _getMeterSize ?? 1000
        )
        _map.setRegion(region, animated: true)
    }
    
    
    init(
        setMeterSize : Double? = 1000
    ) {
        super.init(frame: .zero)
        self._getMeterSize = setMeterSize // 1,000 meter == 1km
        
        setMap()
        setUI()
        addMarkerPin(latitude: 37.572907, longitude: 126.976839, title: "세종대왕 동상", subTitle: "서울시 종로구 머시기머시기")
        let mhomeLatitude = 37.574879
        let mhomeLongitude = 126.672701
        addMarkerPin(latitude: mhomeLatitude, longitude: mhomeLongitude, title: "우리집", subTitle: "서울시")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // mapview pin 꾸미기
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView

        let rightButton = UIImageView(image: UIImage(systemName: "star.fill"))
        rightButton.isUserInteractionEnabled = true // 이미지 뷰도 클릭 가능하도록 설정
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            pinView?.rightCalloutAccessoryView = rightButton
        } else {
            pinView?.annotation = annotation
        }

        return pinView
    }
  
    // 핀 클릭시 이벤트
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            // annotation을 통해 클릭된 핀의 정보에 접근할 수 있습니다.
            let title = annotation.title ?? ""
            let subtitle = annotation.subtitle ?? ""
            
            buttonTapped?(title, subtitle)

        }
    }
    
    var buttonTapped: ((String?, String?) -> Void)?
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? MKPointAnnotation {
            // 클릭된 핀의 정보에 접근할 수 있습니다.
            let title = annotation.title ?? ""
            let subtitle = annotation.subtitle ?? ""
            
            // 예: 클릭시 다른 화면으로 이동하는 등의 동작 수행 가능
//            buttonTapped?(title, subtitle)
        }
    }
}


