//
//  JobController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/29.
//

import Foundation
import UIKit

class JobController: UIViewController {
   
    
    // ViewModel 설정 메서드 (외부에서 호출)
    private var pipeVM: PipeVM?
    func configurePipeVM(pipeVM: PipeVM) {
        self.pipeVM = pipeVM
        setupChildControllers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // 스토리보드에서 생성 시 이 생성자가 호출됨
    }
    
    // 하위 컨트롤러들
    private var employmentController: EmploymentController?
    private var contestController: ContestController?
    private var jobFairController: JobFairController?
    private var certificationController: CertificationController?
    private func setupChildControllers() {
        guard let pipeVM = pipeVM else { return }
        
        // 하위 컨트롤러 초기화
        employmentController = EmploymentController(setPipeVM: pipeVM)
        contestController = ContestController(setPipeVM: pipeVM)
        jobFairController = JobFairController(setPipeVM: pipeVM)
        certificationController = CertificationController(setPipeVM: pipeVM)
        
        setupTabLayout()
    }
    
    // 탭 레이아웃 설정
    private var tabLayout: TabLayout?
    private func setupTabLayout() {
        guard let employmentController = employmentController,
              let contestController = contestController,
              let jobFairController = jobFairController,
              let certificationController = certificationController else { return }
        
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // ARC로 대부분 자동 관리됨
    }
    
    // ViewModel에 접근하는 메서드 (다른 컨트롤러에서 필요할 경우)
    func getPipeVM() -> PipeVM? {
        return pipeVM
    }
}
