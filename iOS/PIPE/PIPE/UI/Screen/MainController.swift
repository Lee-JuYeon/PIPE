//
//  ViewController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/26.
//

import UIKit

class MainController: UITabBarController {
    private var pipeVM: PipeVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColour
        setupViewModel()
        injectViewModelsToChildControllers()
    }
    
    private func setupViewModel() {
        // ViewModel에 필요한 Repository 생성
        let moneyRepository = MoneyRepositoryImpl()
        let jobRepository = JobRepositoryImpl()
        let placeRepository = PlaceRepositoryImpl()
        
        // PipeVM 인스턴스 생성
        pipeVM = PipeVM(
            setMoneyRepository: moneyRepository,
            setJobRepository: jobRepository,
            setPlaceRepository: placeRepository
        )
    }
    
    private func injectViewModelsToChildControllers() {
        guard let pipeVM = pipeVM, let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            if let navigationController = viewController as? UINavigationController,
               let childVC = navigationController.topViewController {
                injectViewModelToController(childVC, pipeVM: pipeVM)
            } else {
                injectViewModelToController(viewController, pipeVM: pipeVM)
            }
        }
    }
    
    private func injectViewModelToController(_ viewController: UIViewController, pipeVM: PipeVM) {
        switch viewController {
        case let moneyController as MoneyController:
            moneyController.configurePipeVM(pipeVM: pipeVM)
        case let placeController as PlaceController:
            placeController.configurePipeVM(pipeVM: pipeVM)
        case let jobController as JobController:
            jobController.configurePipeVM(pipeVM: pipeVM)
        default:
            break // 해당되지 않는 뷰 컨트롤러는 처리하지 않음
        }
    }
}

//extension MainController: PipeVMProtocol {
//    func getPipeVM() -> PipeVM {
//        // MainController에서의 pipeVM 생성 및 반환
//        let moneyRepository = MoneyRepositoryImpl()
//        let placeRepository = PlaceRepositoryImpl()
//
//        let pipeVM = PipeVM(
//            setMoneyRepository: moneyRepository,
//            setPlaceRepository: placeRepository
//        )
//        return pipeVM
//    }
//
//    func test() {
//        print("인스턴스 테스트")
//    }
//}
