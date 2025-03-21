//
//  OfficeController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import UIKit
import RxSwift
import WebKit
import MapKit


class OfficeController : UIViewController, CustomModulerUIDelegate {
    
    private var pipeVM: PipeVM?
    init(
        setPipeVM : PipeVM?
    ){
        super.init(nibName: nil, bundle: nil)
        pipeVM = setPipeVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mapView : MapView = {
        let view = MapView(
            setMeterSize: 1000
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailSearchView : UIView = {
        let view = UILabel()
        view.text = "상세내욤ㄴ애러메ㅐㅑ허ㅔ"
        view.textColor = .black
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var customModulerView : CustomModulerUI<OfficeModel, OfficeCell> = {
        let view = CustomModulerUI<OfficeModel, OfficeCell>(
            optionView: detailSearchView,
            contentView: mapView,
            delegate: self
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

  
    private var officeList : [OfficeModel] = [] {
        didSet {
            // homeList가 업데이트될 때마다 화면 갱신
            customModulerView.updateList(newList: self.officeList)
        }
    }
    private func initOfficeList(){
        pipeVM?.officeList.subscribe(onNext: { list in
            self.officeList = list
        }, onError: { error in
            self.officeList = []
            print("OfficeController, initOfficeList // Error : \(error.localizedDescription)")
        }, onCompleted: {
            print("OfficeController, initOfficeList // Completed")
        }, onDisposed: {
            print("OfficeController, initOfficeList // Disposed")
        })
    }

   
//    func cancelAllCellFocusAnimation(){
//        for (index, item) in self.officeList.enumerated() {
//            let indexPath = IndexPath(row: index, section: 0)
//            if let cell = listView.cellForRow(at: indexPath) as? OfficeCell {
//                cell.isFocuse = false
//            }
//        }
//    }
    

//    func findCellByPin(title : String, subTitle : String){
//        for (index, item) in self.officeList.enumerated() {
//            let indexPath = IndexPath(row: index, section: 0)
//
//            if item.buildingAddress == subTitle {
//                self.listView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//
//            let isFocused = item.buildingAddress == subTitle
//            if item.buildingAddress == subTitle {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.listView.scrollToRow(at: indexPath, at: .top, animated: true)
//                    
//                    // 1초 후에 cellForRow를 실행
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
//                        if let cell = self.listView.cellForRow(at: indexPath) as? OfficeCell {
//                            cell.isFocuse = true
//                        }
//                    }
//                }
//            }else{
//                if let cell = listView.cellForRow(at: indexPath) as? OfficeCell {
//                    cell.isFocuse = false
//                }
//            }
//
//        }
//    }
    
    func didTapCell(model: AnyHashable, atIndex index: Int) {
        switch model {
          case let homeModel as HomeModel:
              // HomeModel 타입일 때의 로직
              print("homeModel : \(homeModel.company), \(index)번째")
          case let officeModel as OfficeModel:
              // OfficeModel 타입일 때의 로직
              print("officeModel : \(officeModel), \(index)번째")
          default:
              // 다른 타입의 모델일 때의 로직
              print("클릭된 거 : \(model), \(index)번째")
        }
        // 여기에서 셀 클릭 이벤트에 대한 로직을 처리합니다.
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initOfficeList()

        view.addSubview(customModulerView)
        view.backgroundColor = .clear

        
        NSLayoutConstraint.activate([
            customModulerView.topAnchor.constraint(equalTo: view.topAnchor),
            customModulerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customModulerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customModulerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        customModulerView.setCellBinding({ cell, model, index in
            cell.bind(model: model)
        })
        
        mapView.buttonTapped = { title, subtitle in
//            if let title = title, let subtitle = subtitle {
//                self.findCellByPin(title: title, subTitle: subtitle)
//            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
   
}
//
//extension OfficeController :
//    UITableViewDataSource,
//    UITableViewDelegate,
//    WKNavigationDelegate,
//    WKUIDelegate,
//    MKMapViewDelegate
//{
//    // 데이터 소스 개수 반환
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return officeList.count
//    }
//
//    // 셀 반환
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = dataSource.itemIdentifier(for: indexPath)
//
//        switch model {
//        case is OfficeModel :
//            let cell = tableView.dequeueReusableCell(withIdentifier: "OfficeCell", for: indexPath) as! OfficeCell
//            cell.bind(model: model as! OfficeModel)
//            return cell
//        case is GoogleAdmobModel :
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AdmobCell", for: indexPath) as! GoogleAdmobCell
//            cell.bind(model: model as! GoogleAdmobModel)
//            return cell
//        default :
//            // 셀 생성 및 재사용
//            let cell = tableView.dequeueReusableCell(withIdentifier: "OfficeCell", for: indexPath) as! OfficeCell
//            cell.bind(model: model as! OfficeModel)
//            return cell
//        }
//    }
//
//    // 셀 클릭시
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        let selectedItem = officeList[indexPath.row]
//        print("Selected item: \(selectedItem)")
//
//        let mhomeLatitude = 37.574879
//        let mhomeLongitude = 126.672701
//        mapView.moveCamera(setLatitude: mhomeLatitude, setLongitude: mhomeLongitude)
////        cancelAllCellFocusAnimation()
//    }
//}
