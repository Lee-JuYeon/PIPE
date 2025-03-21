//
//  CalendarController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import UIKit

class CalendarController : UIViewController {
    private var vm: LocalVM?
    init(
        setVM : LocalVM?
    ){
        super.init(nibName: nil, bundle: nil)
        vm = setVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
