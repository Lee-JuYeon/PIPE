//
//  MoneyController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/27.
//

import Foundation
import UIKit

class MoneyController: UIViewController {
    private let pipeVM: PipeVM // 옵셔널 제거
    private var tabLayout: TabLayout?
    
    // 하위 컨트롤러들 (옵셔널 대신 강제 초기화)
    private let supportController: SupportController
    private let depositController: BackController
    
    // 초기화
    init(setPipeVM: PipeVM) { // 옵셔널 파라미터 제거
        self.pipeVM = setPipeVM
        
        // 하위 컨트롤러 초기화
        self.supportController = SupportController(setPipeVM: setPipeVM)
        self.depositController = BackController(setPipeVM: setPipeVM)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 탭 레이아웃 설정
    private func setupTabLayout() {
        let controllerList: [UIViewController] = [
            supportController,
            depositController
        ]
        
        tabLayout = TabLayout(
            setTabList: [
                TabModel(title: "TITLE_MONEY_SUPPORT".toLocalize()),
                TabModel(title: "TITLE_MONEY_SAVING_BASIC".toLocalize())
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
