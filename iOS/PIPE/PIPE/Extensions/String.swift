//
//  String.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/17.
//

import Foundation
import UIKit

extension String {
    
    func openWebsite() -> String {
        if #available(iOS 13, *) {
            if let url = URL(string: self) {
                UIApplication.shared.open(url)
                return "success"
            }else{
                print("openWebsite // string nil exception")
                return "nil"
            }
        } else {
            print("openWebsite // 13버전 이상 호환 메소드 필요")
            return "상위 버전필요"
        }
    }
    
    func toLocalize() -> String{
        return String(format: NSLocalizedString(self, comment: ""))
    }
}
