//
//  UIViewController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/19.
//

import Foundation
import UIKit

extension UIViewController {
    func calculateMargin(padding: CGFloat) -> CGFloat {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.windows.first {
                let safeAreaInsets = window.safeAreaInsets
                return safeAreaInsets.top + (padding * 2)
            }
        } else if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                let safeAreaInsets = window.safeAreaInsets
                return safeAreaInsets.top + (padding * 2)
            }
        }
        return padding * 3
    }
    
    
}
