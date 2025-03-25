//
//  DepositModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//
import UIKit

class MemoCell: UITableViewCell {
    static let identifier = "MemoCell"
    
    // 셀 상태를 추적
    private var isExpanded = false
    private var fullContent: String = ""
    
    // UI 요소
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // 높이 제약 조건
    private var contentHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // 초기 높이 제약 (축소 상태)
        contentHeightConstraint = contentTextView.heightAnchor.constraint(equalToConstant: 0)
        contentHeightConstraint?.isActive = true
    }
    
    func configure(with memo: MemoModel, isExpanded: Bool = false) {
        self.fullContent = memo.content
        self.titleLabel.text = memo.firstLine
        self.contentTextView.text = memo.content
        self.isExpanded = isExpanded
        
        updateExpandedState()
    }
    
    func toggleExpanded() {
        isExpanded = !isExpanded
        updateExpandedState()
    }
    
    private func updateExpandedState() {
        contentTextView.isHidden = !isExpanded
        
        if isExpanded {
            // 확장 상태 - 더 크게 설정 (200으로 확장)
            contentHeightConstraint?.constant = 200
            contentTextView.isScrollEnabled = true
        } else {
            // 축소 상태
            contentHeightConstraint?.constant = 0
            contentTextView.isScrollEnabled = false
        }
        
        // 레이아웃 업데이트
        contentView.layoutIfNeeded()
    }
}
