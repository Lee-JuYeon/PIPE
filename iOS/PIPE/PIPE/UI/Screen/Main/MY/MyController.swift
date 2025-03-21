//
//  MyController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/03.
//

import Foundation
import UIKit

class MyController : UIViewController {
    
    private var tabLayout : TabLayout? = nil
    private func setTabLayout(controllerList : [UIViewController]){
        let mTabLayout : TabLayout = {
            let view = TabLayout(
                setTabList: [
                    TabModel(title: "메모"),
                    TabModel(title: "일정"),
                    TabModel(title: "공지사항")
                ],
                setControllers: controllerList,
                setParentVC: self
            )
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        if tabLayout == nil {
            tabLayout = mTabLayout
        }
    }
    
    private var myVM : LocalVM?
    private func setVM(){
        let repository = LocalRepositoryImpl()
        let vm = LocalVM(
            setRepository : repository
        )
        myVM = vm
    }
    
    private var memoController : MemoController? = nil
    private var calendarController : CalendarController? = nil
    private var notificationController : NotificationController? = nil
    private func setUI(){
        memoController = MemoController()
        calendarController = CalendarController(setVM: myVM)
        notificationController = NotificationController(setVM: myVM)
        let controllerList : [UIViewController] = [
            memoController ?? MemoController(),
            calendarController ?? CalendarController(setVM: myVM),
            notificationController ?? NotificationController(setVM: myVM)
        ]
        setTabLayout(controllerList: controllerList)
        
        view.backgroundColor = .clear
        view.addSubview(tabLayout!)
        
        if tabLayout != nil {
            NSLayoutConstraint.activate([
                tabLayout!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tabLayout!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabLayout!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabLayout!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVM()
        setUI()
       
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabLayout = nil
        myVM = nil
        
        calendarController = nil
        notificationController = nil
        memoController = nil
    }
}
