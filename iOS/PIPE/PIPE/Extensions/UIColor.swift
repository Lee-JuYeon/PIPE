//
//  UIColor.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/02.
//

import Foundation
import UIKit

extension UIColor {
    static var reverseTextColour: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return .white
                } else {
                    return .black
                }
            }
        } else {
            return .white
        }
    }
    
    static var textColour: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return .black
                } else {
                    return .white
                }
            }
        } else {
            return .black
        }
    }
    
    static var backgroundColour: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor(named:"BackgroundColour") ?? .white
                } else {
                    return UIColor(named:"BackgroundColour") ?? .black
                }
            }
        } else {
            return UIColor(named:"BackgroundColour") ?? .white
        }
    }
    
    static var darkShadow: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor(named:"DarkShadow") ?? .white
                } else {
                    return UIColor(named:"DarkShadow") ?? .black
                }
            }
        } else {
            return UIColor(named:"DarkShadow") ?? .white
        }
    }
    
    static var lightShadow: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor(named:"LightShadow") ?? .white
                } else {
                    return UIColor(named:"LightShadow") ?? .black
                }
            }
        } else {
            return UIColor(named:"DarkShadow") ?? .white
        }
    }

    
    static func brightenColor(color: UIColor, factor: CGFloat) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            red = min(red + factor, 1.0)
            green = min(green + factor, 1.0)
            blue = min(blue + factor, 1.0)
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return nil
    }

    static func darkenColor(color: UIColor, factor: CGFloat) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            red = max(red - factor, 0.0)
            green = max(green - factor, 0.0)
            blue = max(blue - factor, 0.0)
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return nil
    }
}
