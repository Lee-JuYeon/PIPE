//
//  CellBankBasic.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import UIKit

class BankBasicSavingCell : UITableViewCell {
    
    // 클릭 이벤트 처리할 클로져
//    var clickAction : (() -> Void) = {}
    
    
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
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickEvent))
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(tapGestureRecognizer)

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
        
    func bind(model: BasicSavingModel) {
        nameLabel.text = model.fin_prdt_nm
        rewardLabel.text = "BasicSavingModel"
        descriptionLabel.text = model.kor_co_nm
    }
    
//    @objc func clickEvent(){
//        clickAction()
//    }
}

