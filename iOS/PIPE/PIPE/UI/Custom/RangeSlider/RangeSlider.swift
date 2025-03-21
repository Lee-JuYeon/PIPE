//
//  RangeSlider.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/08/20.
//

import Foundation
import UIKit

class RangeSlider : UIView {
    private let slider : UISlider = {
        let view = UISlider()
        view.minimumValue = 0.0
        view.maximumValue = 100.0
        view.value = 30.0
        view.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func sliderValueChanged(_ sender : UISlider){
        let value = sender.value
        print("Slider value changed to: \(value)")
    }
    
    private func customiseThumb(setUIimage : UIImage?){
        slider.setThumbImage(setUIimage, for: .normal)
    }
            
    private func setUI() {
        addSubview(slider)
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: topAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor) 
        ])
    }
    
    init(
        setBackgroundColour : UIColor,
        setUIImage : UIImage?
    ){
        super.init(frame: .zero)
        customiseThumb(setUIimage: setUIImage)
        slider.backgroundColor = setBackgroundColour
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//class RangeSlider: UIControl {
//
//    var lowerThumbImageView = UIImageView(image: UIImage(systemName: "app.fill"))
//    var upperThumbImageView = UIImageView(image: UIImage(systemName: "app.fill"))
//    let trackView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .yellow
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    var minimumValue: Float = 0
//    var maximumValue: Float = 1000 {
//        didSet {
//            updateThumbPositions()
//        }
//    }
//    var lowerValue: Float = 0 {
//        didSet {
//            updateThumbPositions()
//        }
//    }
//    var upperValue: Float = 1000 {
//        didSet {
//            updateThumbPositions()
//        }
//    }
//
//    var lowerThumbSelected = false
//    var upperThumbSelected = false
//
//    private func setupSlider() {
//        addSubview(trackView)
//        addSubview(lowerThumbImageView)
//        addSubview(upperThumbImageView)
//
//        NSLayoutConstraint.activate([
//            trackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            trackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            trackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            trackView.heightAnchor.constraint(equalToConstant: 5.0)
//        ])
//
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        updateThumbPositions()
//
//        // 드래그 제스처 추가
//        let lowerPanGesture = UIPanGestureRecognizer(target: self, action: #selector(lowerThumbDragged(_:)))
//        lowerThumbImageView.addGestureRecognizer(lowerPanGesture)
//        lowerThumbImageView.isUserInteractionEnabled = true
//
//        let upperPanGesture = UIPanGestureRecognizer(target: self, action: #selector(upperThumbDragged(_:)))
//        upperThumbImageView.addGestureRecognizer(upperPanGesture)
//        upperThumbImageView.isUserInteractionEnabled = true
//
//    }
//
//    private func updateThumbPositions() {
//        let trackWidth = trackView.bounds.size.width
//        let valueRange = maximumValue - minimumValue
//        let lowerX = CGFloat((lowerValue - minimumValue) / valueRange) * trackWidth
//        let upperX = CGFloat((upperValue - minimumValue) / valueRange) * trackWidth
//
//        lowerThumbImageView.frame = CGRect(x: lowerX - lowerThumbImageView.bounds.size.width / 2, y: bounds.size.height / 2 - lowerThumbImageView.bounds.size.height / 2, width: lowerThumbImageView.bounds.size.width, height: lowerThumbImageView.bounds.size.height)
//        upperThumbImageView.frame = CGRect(x: upperX - upperThumbImageView.bounds.size.width / 2, y: bounds.size.height / 2 - upperThumbImageView.bounds.size.height / 2, width: upperThumbImageView.bounds.size.width, height: upperThumbImageView.bounds.size.height)
//    }
//
//    @objc private func lowerThumbDragged(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: self)
//        let newX = lowerThumbImageView.center.x + translation.x
//        let normalizedX = max(min(newX, bounds.width), 0)
//        let valueRange = maximumValue - minimumValue
//        let newFloatValue = minimumValue + Float(normalizedX / bounds.width) * valueRange
//        lowerValue = max(min(newFloatValue, upperValue), minimumValue)
//
//        gesture.setTranslation(.zero, in: self)
//        updateThumbPositions()
//
//        if gesture.state == .ended {
//            lowerThumbSelected = false
//            sendActions(for: .valueChanged)
//        } else {
//            lowerThumbSelected = true
//        }
//    }
//
//    @objc private func upperThumbDragged(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: self)
//        let newX = upperThumbImageView.center.x + translation.x
//        let normalizedX = max(min(newX, bounds.width), 0)
//        let valueRange = maximumValue - minimumValue
//        let newFloatValue = minimumValue + Float(normalizedX / bounds.width) * valueRange
//        upperValue = max(min(newFloatValue, maximumValue), lowerValue)
//
//        gesture.setTranslation(.zero, in: self)
//        updateThumbPositions()
//
//        if gesture.state == .ended {
//            upperThumbSelected = false
//            sendActions(for: .valueChanged)
//        } else {
//            upperThumbSelected = true
//        }
//    }
//
//    init(
//        setBackgroundColour : UIColor
//    ){
//        super.init(frame: .zero)
//        trackView.backgroundColor = setBackgroundColour
//        setupSlider()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}
//
