//
//  JobController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/29.
//

import Foundation
import UIKit

class JobController: UIViewController {
    private let pipeVM: PipeVM
    private var tabLayout: TabLayout?
    
    // 하위 컨트롤러들 (옵셔널 대신 강제 초기화로 관리)
    private let employmentController: EmploymentController
    private let contestController: ContestController
    private let jobFairController: JobFairController
    private let certificationController: CertificationController
    
    // 초기화
    init(setPipeVM: PipeVM) {
        self.pipeVM = setPipeVM
        
        // 하위 컨트롤러 초기화
        self.employmentController = EmploymentController(setPipeVM: setPipeVM)
        self.contestController = ContestController(setPipeVM: setPipeVM)
        self.jobFairController = JobFairController(setPipeVM: setPipeVM)
        self.certificationController = CertificationController(setPipeVM: setPipeVM)
        
        super.init(nibName: nil, bundle: nil) // 필수: super.init 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 탭 레이아웃 설정
    private func setupTabLayout() {
        let controllerList: [UIViewController] = [
            employmentController,
            contestController,
            jobFairController,
            certificationController
        ]
        
        tabLayout = TabLayout(
            setTabList: [
                TabModel(title: "취직"),
                TabModel(title: "공모전"),
                TabModel(title: "박람회"),
                TabModel(title: "자격증")
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
        // 필요한 경우만 nil 설정, ARC로 대부분 자동 관리됨
        tabLayout = nil
    }
}
