//
//  ContestController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/29.
//

import Foundation
import UIKit

class ContestController : UIViewController, CustomModulerUIDelegate {
    
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
            contentView: nil,
            delegate: self
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

  
//    private var officeList : [OfficeModel] = [] {
//        didSet {
//            // homeList가 업데이트될 때마다 화면 갱신
//            customModulerView.updateList(newList: self.officeList)
//        }
//    }
//    private func initOfficeList(){
//        placeVM?.officeList.subscribe(onNext: { list in
//            self.officeList = list
//        }, onError: { error in
//            self.officeList = []
//            print("OfficeController, initOfficeList // Error : \(error.localizedDescription)")
//        }, onCompleted: {
//            print("OfficeController, initOfficeList // Completed")
//        }, onDisposed: {
//            print("OfficeController, initOfficeList // Disposed")
//        })
//        
//        placeVM?.loadOfficeList()
//    }

   
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
//        initOfficeList()

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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
   
}
