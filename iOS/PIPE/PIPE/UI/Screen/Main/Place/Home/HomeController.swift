//
//  HomeController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import UIKit
import RxSwift
import WebKit
import MapKit

class HomeController : UIViewController, CustomModulerUIDelegate {
    
    private var pipeVM: PipeVM?
    private var homeList : [HomeModel] = [] {
        didSet {
            // homeList가 업데이트될 때마다 화면 갱신
            customModulerView.updateList(newList: homeList)
        }
    }
    private var disposeBag = DisposeBag()
    private func initHomeList(){
        pipeVM?.homeList.subscribe(onNext: { list in
            self.homeList = list
        }, onError: { error in
            self.homeList = []
            print("HomeController, initHomeList // Error : \(error.localizedDescription)")
        }, onCompleted: {
            print("HomeController, initHomeList // Completed")
        }, onDisposed: {
            print("HomeController, initHomeList // Disposed")
        }).disposed(by: disposeBag) // 'disposeBag'에 해당 구독을 추가하여 경고를 해결합니다.
    }
    
    init(
        setPipeVM : PipeVM?
    ){
        super.init(nibName: nil, bundle: nil)
        pipeVM = setPipeVM
        initHomeList()
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

    lazy var customModulerView : CustomModulerUI<HomeModel, HomeCell> = {
        let view = CustomModulerUI<HomeModel, HomeCell>(
            optionView: detailSearchView,
            contentView: mapView,
            delegate: self
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

   
    
    func didTapCell(model: AnyHashable, atIndex index: Int) {
        switch model {
          case let homeModel as HomeModel:
              // HomeModel 타입일 때의 로직
              print("클릭된 거 : \(homeModel.company), \(index)번째")
          case let officeModel as OfficeModel:
              // OfficeModel 타입일 때의 로직
              print("클릭된 거 : \(officeModel), \(index)번째")
          default:
              // 다른 타입의 모델일 때의 로직
              print("클릭된 거 : \(model), \(index)번째")
        }
        // 여기에서 셀 클릭 이벤트에 대한 로직을 처리합니다.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
