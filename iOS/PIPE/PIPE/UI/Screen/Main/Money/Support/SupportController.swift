//
//  SupportController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/28.
//

// MVVM + Repository + RxSwift
// MVVM + Repository + Combine

import Foundation
import UIKit
import Combine
import WebKit

class SupportController : UIViewController, CustomModulerUIDelegate {
    
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
    
    lazy var customModulerView : CustomModulerUI<SupportModel, SupportCell> = {
        let view = CustomModulerUI<SupportModel, SupportCell>(
            optionView: detailSearchView,
            contentView: nil,
            delegate: self
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

  
//    var supportList : [SupportModel] = [] {
//        didSet {
//            // homeList가 업데이트될 때마다 화면 갱신
//            customModulerView.updateList(newList: self.supportList)
//        }
//    }
//
//    private var supportCancellables = Set<AnyCancellable>()
//    private func initSupportList(){
//        moneyVM?.supportList
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("BankSupportController, initSupportList, sink // 비동기 작업이 성공적으로 끝남")
//                case .failure(let error):
//                    print("BankSupportController, initSupportList, sink // error: \(error.localizedDescription)")
//                }
//            }, receiveValue: { list in
//                self.supportList = list
//            })
//            .store(in: &supportCancellables)
//
//
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
          case let supportModel as SupportModel:
            print("homeModel : \(supportModel.name), \(index)번째")
          default:
              // 다른 타입의 모델일 때의 로직
              print("클릭된 거 : \(model), \(index)번째")
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        initSupportList()

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

//class BankSupportController :
//    UIViewController
//{
//
//    lazy var keywordSearchView : DropDownTextField = {
//        let view = DropDownTextField()
//        view.dropdownList = ["1111", "2222", "3333", "4444"]
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    lazy var keywordSearchView2 : DropDownTextField = {
//        let view = DropDownTextField()
//        view.dropdownList = ["ㅁㅁㅁ", "ㄴㄴㄴㄴ", "ㄹㄹㄹㄹ", "ㅃㅃㅃㅃ"]
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    // gender
//    lazy var genderSwitch: UISwitch = {
//        // Create a Switch.
//        let swicth: UISwitch = UISwitch()
//
//        // Display the border of Swicth.
//        swicth.tintColor = UIColor.orange
//
//        // Set Switch to On.
//        swicth.isOn = true
//
//        // Set the event to be called when switching On / Off of Switch.
////        swicth.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
////        swicth.translatesAutoresizingMaskIntoConstraints = false
//
//        return swicth
//    }()
//
//    // neumorphism background
//    lazy var neumorphismBackground : NeumorphismView = {
//        let setRadius : CGFloat = 10
//        let view = NeumorphismView(setRadius: setRadius)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//
//    // table view
//    lazy var apiDataListView : UITableView = {
//        let view = UITableView()
//        view.separatorStyle = .none
//        view.backgroundColor = .clear
//        view.allowsSelection = true
//        view.isUserInteractionEnabled = true
//        view.delegate = self
//        view.dataSource = self
//        view.register(SupportCell.self, forCellReuseIdentifier: "SupportCell")
//        view.register(GoogleAdmobCell.self, forCellReuseIdentifier: "GoogleAdmobCell")
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    lazy var customWebView : WKWebView = {
//        let view = WKWebView()
//        view.navigationDelegate = self
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(neumorphismBackground)
//        view.addSubview(keywordSearchView)
//        view.addSubview(keywordSearchView2)
//        view.addSubview(apiDataListView)
//        view.addSubview(genderSwitch)
//
//        view.backgroundColor = .clear
//
//        let padding : CGFloat = 20
//
//        NSLayoutConstraint.activate([
//            keywordSearchView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding * 2),
//            keywordSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : padding * 2),
//            keywordSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -(padding * 2)),
//            keywordSearchView.heightAnchor.constraint(equalToConstant: 40),
//
//            keywordSearchView2.topAnchor.constraint(equalTo: keywordSearchView.bottomAnchor, constant: padding * 2),
//            keywordSearchView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : padding * 2),
//            keywordSearchView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -(padding * 2)),
//            keywordSearchView2.heightAnchor.constraint(equalToConstant: 40),
//
//
//            genderSwitch.topAnchor.constraint(equalTo: keywordSearchView2.bottomAnchor, constant: padding/2),
//            genderSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : padding * 2),
//            genderSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -(padding * 2)),
//
//
//            neumorphismBackground.topAnchor.constraint(equalTo: keywordSearchView.topAnchor, constant: -padding),
//            neumorphismBackground.bottomAnchor.constraint(equalTo: genderSwitch.bottomAnchor, constant: padding),
//            neumorphismBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : padding),
//            neumorphismBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -padding),
//
//
//            apiDataListView.topAnchor.constraint(equalTo: neumorphismBackground.bottomAnchor, constant: padding),
//            apiDataListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            apiDataListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : 0),
//            apiDataListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : 0)
//        ])
//
//
//    }
//
//    var pipeVM : PipeVM?
//    func setPipeVM(){
//        if let moneyVC = self.parent{
//            if let mainVC = moneyVC.parent as? MainController{
//                pipeVM = mainVC.getPipeVM()
//            }
//        }
//    }
//
//    let disposeBag = DisposeBag()
//    var supportModelList : [Any] = []
//    func bindTableView(){
//        do{
////            let moneyRepository = MoneyRepositoryImpl()
////            if pipeVM == nil {
////                pipeVM = PipeVM(setMoneyRepository: moneyRepository)
////            }
////
////            pipeVM.depositSavingList
////                .subscribe { list in
////                    self.supportModelList = list
////                    self.apiDataListView.reloadData()
////                } onError: { itemsError in
////                    print("vm : itemsError : \(itemsError.localizedDescription)")
////                } onCompleted: {
////
////                } onDisposed: {
////
////                }
////                .disposed(by: disposeBag)
////
////            pipeVM.loadDepositSavingList()
//        }catch{
//            print("SupportController, bindTableView // error : \(error.localizedDescription)")
//        }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        setPipeVM()
//        bindTableView()
////        // 키보드 올리기를 위한 제스처 추가
////        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardTap))
////        view.addGestureRecognizer(tapGesture)
//    }
//
//}
//
//
//extension SupportController :
//    UITableViewDataSource,
//    UITableViewDelegate,
//    WKNavigationDelegate,
//    WKUIDelegate
//{
//    // 데이터 소스 개수 반환
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return supportModelList.count
//    }
//
//    // 셀 반환
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let position = indexPath.row
//        let model = supportModelList[position]
//
//        let supportCell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
//        supportCell.bind(model: model as! SupportModel)
//        return supportCell
////        switch model {
////        case is SupportModel :
////            // 셀 생성 및 재사용
////            let supportCell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
////            supportCell.bind(model: model as! SupportModel)
////            return supportCell
////        case is GoogleAdmobModel :
////            // 셀 생성 및 재사용
////            let admobCell = tableView.dequeueReusableCell(withIdentifier: "AdmobCell", for: indexPath) as! GoogleAdmobCell
////            admobCell.bind(model: model as! GoogleAdmobModel)
////            return admobCell
////        default :
////            // 셀 생성 및 재사용
////            let supportCell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
////            supportCell.bind(model: model as! SupportModel)
////            return supportCell
////        }
//    }
//
//    // 셀 클릭시
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        let selectedItem = supportModelList[indexPath.row]
//        print("Selected item: \(selectedItem)")
//
//        // 웹 페이지 로드
//        "https://naver.com".openWebsite()
//    }
//}
//
//
