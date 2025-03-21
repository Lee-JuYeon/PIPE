//
//  PlaceVmProtocol.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/08/02.
//

import Foundation
import UIKit
import Combine
import WebKit

class BackController: UIViewController, CustomModulerUIDelegate {
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
    
    lazy var customModulerView : CustomModulerUI<DepositSavingModel, BankDepositSavingCell> = {
        let view = CustomModulerUI<DepositSavingModel, BankDepositSavingCell>(
            optionView: detailSearchView,
            contentView: nil,
            delegate: self
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

  
    var depositSavingList : [DepositSavingModel] = [] {
        didSet {
            // homeList가 업데이트될 때마다 화면 갱신
            customModulerView.updateList(newList: self.depositSavingList)
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
   

    func didTapCell(model: AnyHashable, atIndex index: Int) {
        switch model {
          case let depositSavingModel as DepositSavingModel:
            print("depositSavingModel : \(depositSavingModel.fin_prdt_nm), \(index)번째")
           
//            let bottomSheetVC = CustomBottomSheet(contentViewController: UIViewController())
//            bottomSheetVC.modalPresentationStyle = .overFullScreen
//            self.present(bottomSheetVC, animated: false, completion: nil)
          default:
              // 다른 타입의 모델일 때의 로직
              print("클릭된 거 : \(model), \(index)번째")
        }
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
   
    
}


//class BankLoanController : UIViewController, CustomModulerUIDelegate {
//
//    private var moneyVM: MoneyVM?
//    init(
//        setVM : MoneyVM?
//    ){
//        super.init(nibName: nil, bundle: nil)
//        moneyVM = setVM
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private lazy var keywordSearchView : DropDownTextField = {
//        let view = DropDownTextField()
//        view.dropdownList = ["1111", "2222", "3333", "4444"]
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//
//    lazy var customWebView : WKWebView = {
//        let view = WKWebView()
//        view.navigationDelegate = self
//        return view
//    }()
//
//    private lazy var keywordSearchView2 : DropDownTextField = {
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
//        swicth.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
//        swicth.translatesAutoresizingMaskIntoConstraints = false
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
//    lazy var customWebView : WKWebView = {
//        let view = WKWebView()
//        view.navigationDelegate = self
//        return view
//    }()
//
//    lazy var customModulerView : CustomModulerUI<SupportModel, SupportCell> = {
//        let view = CustomModulerUI<SupportModel, SupportCell>(
//            optionView: detailSearchView,
//            contentView: nil,
//            delegate: self
//        )
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    var loanList : [Supporel] = [] {
//        didSet {
//            // homeList가 업데이트될 때마다 화면 갱신
//            customModulerView.updateList(newList: self.loanList)
//        }
//    }
//
//    private var loaningCancellables = Set<AnyCancellable>()
//    private func initLoanList(){
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initLoanList()
//
//        view.addSubview(customModulerView)
//        view.backgroundColor = .clear
//
//        NSLayoutConstraint.activate([
//            customModulerView.topAnchor.constraint(equalTo: view.topAnchor),
//            customModulerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            customModulerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            customModulerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//
//        customModulerView.setCellBinding({ cell, model, index in
//            cell.bind(model: model)
//        })
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
////                    self.supportModelList += list
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
//extension BankLoanController {
//    @objc func onClickSwitch(sender: UISwitch) {
//        var text: String!
//        var color: UIColor!
//
//        if sender.isOn {
//            text = "On"
//            print(text)
//            color = UIColor.gray
//        } else {
//            text = "Off"
//            print(text)
//            color = UIColor.orange
//        }
//    }
//
//    @objc func handleKeyboardTap() {
//        // 뷰를 탭했을 때, 키보드를 감춤
//        view.endEditing(true)
//    }
//
//    // 키워드로 tableview 필터링.
//    func filterKeyword(keyword : String){
//
//    }
//
//}
//
//
//extension BankLoanController :
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
//        switch model {
//        case is SupportModel :
//            // 셀 생성 및 재사용
//            let supportCell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
//            supportCell.bind(model: model as! SupportModel)
//            return supportCell
//        case is GoogleAdmobModel :
//            // 셀 생성 및 재사용
//            let admobCell = tableView.dequeueReusableCell(withIdentifier: "AdmobCell", for: indexPath) as! GoogleAdmobCell
//            admobCell.bind(model: model as! GoogleAdmobModel)
//            return admobCell
//        default :
//            // 셀 생성 및 재사용
//            let supportCell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
//            supportCell.bind(model: model as! SupportModel)
//            return supportCell
//        }
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



/*
 
 lazy var keywordSearchView : DropDownTextField = {
     let view = DropDownTextField()
     view.dropdownList = ["1111", "2222", "3333", "4444"]
     view.translatesAutoresizingMaskIntoConstraints = false
     return view
 }()
 
 lazy var keywordSearchView2 : DropDownTextField = {
     let view = DropDownTextField()
     view.dropdownList = ["ㅁㅁㅁ", "ㄴㄴㄴㄴ", "ㄹㄹㄹㄹ", "ㅃㅃㅃㅃ"]
     view.translatesAutoresizingMaskIntoConstraints = false
     return view
 }()
 
   var savingList : [SupportModel] = [] {
       didSet {
           // homeList가 업데이트될 때마다 화면 갱신
           customModulerView.updateList(newList: self.savingList)
       }
   }
   
   private var savingCancellables = Set<AnyCancellable>()
   private func initSavingList(){
//          moneyVM?.supportList
//              .sink(receiveCompletion: { completion in
//                  switch completion {
//                  case .finished:
//                      print("BankSavingController, initSavingList, sink // 비동기 작업이 성공적으로 끝남")
//                  case .failure(let error):
//                      print("BankSavingController, initSavingList, sink // error: \(error.localizedDescription)")
//                  }
//              }, receiveValue: { list in
//                  self.savingList = list
//              })
//              .store(in: &savingCancellables)
//
//
   }

 // gender
 lazy var genderSwitch: UISwitch = {
     // Create a Switch.
     let swicth: UISwitch = UISwitch()

     // Display the border of Swicth.
     swicth.tintColor = UIColor.orange
     
     // Set Switch to On.
     swicth.isOn = true
     
     // Set the event to be called when switching On / Off of Switch.
//        swicth.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
//        swicth.translatesAutoresizingMaskIntoConstraints = false

     return swicth
 }()
 */
