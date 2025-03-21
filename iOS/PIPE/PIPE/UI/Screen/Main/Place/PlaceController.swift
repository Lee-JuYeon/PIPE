//
//  PlaceController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/03.
//

import Foundation
import UIKit

class PlaceController: UIViewController {
    private let pipeVM: PipeVM
    private var tabLayout: TabLayout?
    
    // 하위 컨트롤러들 (옵셔널 대신 강제 초기화)
    private let homeController: HomeController
    private let officeController: OfficeController
    
    // 초기화
    init(setPipeVM: PipeVM) {
        self.pipeVM = setPipeVM
        
        // 하위 컨트롤러 초기화
        self.homeController = HomeController(setPipeVM: setPipeVM)
        self.officeController = OfficeController(setPipeVM: setPipeVM)
        
        super.init(nibName: nil, bundle: nil) // 필수: super.init 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 탭 레이아웃 설정
    private func setupTabLayout() {
        let controllerList: [UIViewController] = [
            homeController,
            officeController
        ]
        
        tabLayout = TabLayout(
            setTabList: [
                TabModel(title: "주거 공간"),
                TabModel(title: "상업 공간")
            ],
            setControllers: controllerList,
            setParentVC: self
        )
        tabLayout?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // UI 설정
    private func setupUI() {
        setupTabLayout()
        
        view.backgroundColor = .clear
        if let tabLayout = tabLayout {
            view.addSubview(tabLayout)
            NSLayoutConstraint.activate([
                tabLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tabLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabLayout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
    
    // VM 설정 (빈 메서드로 남아있던 setVM 제거 후 필요 시 추가)
    private func setupVM() {
        // 필요 시 pipeVM 관련 초기화 로직 추가
        // 현재는 빈 메서드로 보이므로 제거하거나 로직 추가 필요
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabLayout = nil // 필요한 경우만 nil 설정
    }
}

//extension PlaceController : PlaceVmProtocol {
//    func initPlaceVM(){
//        // MainController에서의 pipeVM 생성 및 반환
//        let placeRepository = PlaceRepositoryImpl()
//        
//        let vm = PlaceVM(
//            setPlaceRepository: placeRepository
//        )
//        placeVM = vm
//    }
//    
//    func getVM() -> PlaceVM {
//        // MainController에서의 pipeVM 생성 및 반환
//        let placeRepository = PlaceRepositoryImpl()
//        
//        let vm = PlaceVM(
//            setPlaceRepository: placeRepository
//        )
//        return vm
//    }
//}
