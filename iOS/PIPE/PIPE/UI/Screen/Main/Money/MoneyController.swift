//
//  MoneyController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/27.
//
//
//  MoneyController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/27.
//

import Foundation
import UIKit

class MoneyController: UIViewController {
    private var pipeVM: PipeVM?
    private var tabLayout: TabLayout?
    
    // 하위 컨트롤러들
    private var supportController: SupportController?
    private var bankController: BankController?
    
    // ViewModel 설정 메서드 (외부에서 호출)
    func configurePipeVM(pipeVM: PipeVM) {
        self.pipeVM = pipeVM
        setupChildControllers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // 스토리보드에서 생성 시 이 생성자가 호출됨
    }
    
    private func setupChildControllers() {
        guard let pipeVM = pipeVM else { return }
        
        // 하위 컨트롤러 초기화
        supportController = SupportController(setPipeVM: pipeVM)
        bankController = BankController(setPipeVM: pipeVM)
        
        setupTabLayout()
    }
    
    // 탭 레이아웃 설정
    private func setupTabLayout() {
        guard let supportController = supportController,
              let bankController = bankController else { return }
        
        let controllerList: [UIViewController] = [
            supportController,
            bankController
        ]
        
        tabLayout = TabLayout(
            setTabList: [
                TabModel(title: "TITLE_MONEY_SUPPORT".toLocalize()),
                TabModel(title: "TITLE_MONEY_SAVING_BASIC".toLocalize()),
            ],
            setControllers: controllerList,
            setParentVC: self
        )
        tabLayout?.translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
    }
    
    // UI 설정
    private func setupUI() {
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
        // viewDidLoad에서는 setupUI()를 호출하지 않음
        // setupUI()는 pipeVM 주입 후 setupChildControllers()에서 호출됨
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 화면이 나타날 때 필요한 데이터 로드 및 뷰 갱신
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 필요한 경우에만 메모리에서 해제
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 화면을 떠날 때 필요한 작업 처리
    }
    
    // ViewModel에 접근하는 메서드 (다른 컨트롤러에서 필요할 경우)
    func getPipeVM() -> PipeVM? {
        return pipeVM
    }
}
