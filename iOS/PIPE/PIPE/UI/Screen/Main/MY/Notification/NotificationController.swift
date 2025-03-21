//
//  YeahgumResult.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import UIKit

class NotificationController : UIViewController {
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
