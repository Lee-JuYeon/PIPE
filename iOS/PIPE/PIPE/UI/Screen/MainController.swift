//
//  ViewController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/26.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.backgroundColour

    }

//    var pipeVM : PipeVM?
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let fm = FirebaseManager()
//        let ref = fm.ref
//        ref.child("place").observeSingleEvent(of: .value) { snapshot in
//            
//            print("place business value : \(snapshot.value)")
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
