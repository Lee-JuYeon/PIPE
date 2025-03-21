//
//  DepositModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation
import UIKit

class MemoItem: UITableViewCell {
    static let identifier = "MemoItem"
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(memoLabel)
        
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            memoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            memoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with memo: MemoModel) {
        memoLabel.text = memo.firstLine
    }
}
