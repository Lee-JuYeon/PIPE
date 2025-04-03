//
//  MyController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/03.
//

import Foundation
import UIKit

class MyController: UIViewController {
    
    // MARK: - Properties
    
    private var tabLayout: TabLayout?
    private var myVM: LocalVM?
    
    // 하위 컨트롤러들
    private var memoController: MemoController?
    private var calendarController: CalendarController?
    private var notificationController: NotificationController?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVM()
        setUI()
    }
    
    // MARK: - Setup Methods
    
    private func setVM() {
        let repository = LocalRepositoryImpl()
        myVM = LocalVM(setRepository: repository)
    }
    
    private func setUI() {
        // 하위 컨트롤러 초기화
        memoController = MemoController()
        calendarController = CalendarController()
        notificationController = NotificationController(setVM: myVM)
        
        // 컨트롤러 목록 생성
        let controllerList: [UIViewController] = [
            memoController!,
            calendarController!,
            notificationController!
        ]
        
        // TabLayout 생성
        let tabLayoutInstance = TabLayout(
            setTabList: [
                TabModel(title: "메모"),
                TabModel(title: "일정"),
                TabModel(title: "공지사항")
            ],
            setControllers: controllerList,
            setParentVC: self
        )
        
        tabLayout = tabLayoutInstance
        
        // 레이아웃 설정
        tabLayoutInstance.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabLayoutInstance)
        
        NSLayoutConstraint.activate([
            tabLayoutInstance.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabLayoutInstance.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabLayoutInstance.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabLayoutInstance.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
       
    }
    
   
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 메모리 관리
        tabLayout = nil
        myVM = nil
        memoController = nil
        calendarController = nil
        notificationController = nil
    }
}
