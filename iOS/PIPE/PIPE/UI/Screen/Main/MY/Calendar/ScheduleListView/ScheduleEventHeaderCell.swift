//
//  ScheduleEventHeaderCell.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit

// 헤더 셀 구현
class ScheduleHeaderCell: UICollectionViewCell {
    static let identifier = "ScheduleHeaderCell"
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+ 일정 추가", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
