//
//  NuemorphismView.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/03.
//

import UIKit

class NeumorphismView: UIView {

    private var getRadius: CGFloat
    
    init(setRadius: CGFloat) {
        self.getRadius = setRadius
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = getRadius
        layer.insertSublayer(border(), at: 0)
        layer.insertSublayer(gradation(), at: 0)
        layer.insertSublayer(shadowRightBottom(), at: 0)
        layer.insertSublayer(shadowTopLeft(), at: 0)
    }
    
    private func shadowTopLeft() -> CALayer {
        let darkShadow = CALayer()
        darkShadow.backgroundColor = UIColor.brown.cgColor
        darkShadow.shadowColor = UIColor.brightenColor(color: .backgroundColour, factor: 0.3)?.cgColor
        darkShadow.shadowOffset = CGSize(width: -(getRadius * 1), height: -(getRadius * 1))
        darkShadow.shadowOpacity = 1.0
        darkShadow.shadowRadius = getRadius * 2
        darkShadow.cornerRadius = getRadius
        return darkShadow
    }
    
    private func shadowRightBottom() -> CALayer {
        let lightShadow = CALayer()
        lightShadow.backgroundColor = UIColor.backgroundColour.cgColor
        lightShadow.shadowColor = UIColor.darkenColor(color: .backgroundColour, factor: 0.1)?.cgColor
        lightShadow.shadowOffset = CGSize(width: getRadius * 1, height: getRadius * 1)
        lightShadow.shadowOpacity = 1.0
        lightShadow.shadowRadius = getRadius * 2
        lightShadow.cornerRadius = getRadius
        return lightShadow
    }
    
    private func border() -> CALayer {
        let borderLayer = CALayer()
        borderLayer.borderColor = UIColor.reverseTextColour.cgColor
        borderLayer.borderWidth = 1
        borderLayer.cornerRadius = getRadius
        return borderLayer
    }
    
    private func gradation() -> CALayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.backgroundColour.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = getRadius
        return gradientLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.forEach { layer in
            layer.frame = bounds
        }
    }
}

