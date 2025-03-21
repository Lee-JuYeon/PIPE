//
//  OfficeCell.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/08/03.
//

import Foundation
import UIKit

class OfficeCell : UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rewardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
      
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(rewardLabel)
        contentView.addSubview(descriptionLabel)
        self.backgroundColor = .clear

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            rewardLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            rewardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rewardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: rewardLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
        
    private var officeModel : OfficeModel? = nil
    func bind(model: OfficeModel) {
        self.officeModel = model
        nameLabel.text = model.buildingAddress
        rewardLabel.text = model.target
        descriptionLabel.text = model.constructionCompany
    }
    
//    var isFocuse: Bool = false {
//        didSet {
//            if isFocuse {
//                let gradientLayer = CAGradientLayer()
//                let gradationColor = [UIColor.clear, UIColor.white.withAlphaComponent(0.3), UIColor.clear]
//                gradientLayer.frame = self.bounds
//                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//                gradientLayer.colors = gradationColor.map { $0.cgColor }
//                gradientLayer.locations = [0.0, 0.5, 1.0]
//                self.layer.addSublayer(gradientLayer)
//
//                let animation = CABasicAnimation(keyPath: "locations")
//                animation.fromValue = [-0.7, -0.5, 0.0]
//                animation.toValue = [1.0, 1.3, 1.7]
//                animation.repeatCount = .infinity
//                animation.duration = 1.5
//                animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
//                gradientLayer.add(animation, forKey: animation.keyPath)
//
//                self.layer.mask = gradientLayer
//            } else {
//                self.layer.mask?.removeAllAnimations()
//                self.layer.mask?.isHidden = true
//            }
//        }
//    }
}

