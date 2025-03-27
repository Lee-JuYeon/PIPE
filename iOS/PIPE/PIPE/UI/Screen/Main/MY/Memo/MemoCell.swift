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
    
    // UI 요소
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // 높이 제약 조건
    private var containerHeightConstraint: NSLayoutConstraint?
    private var textViewTopConstraint: NSLayoutConstraint?
    private var textViewBottomConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // 텍스트뷰 제약 조건 (별도 저장하여 나중에 활성화/비활성화 가능)
        textViewTopConstraint = contentTextView.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 0)
        textViewBottomConstraint = contentTextView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            contentTextView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 0),
            contentTextView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: 0)
        ])
        
        // 초기 상태에서는 텍스트뷰 제약 조건 비활성화
        textViewTopConstraint?.isActive = false
        textViewBottomConstraint?.isActive = false
        
        // 초기 높이 제약 (축소 상태)
        containerHeightConstraint = contentContainer.heightAnchor.constraint(equalToConstant: 0)
        containerHeightConstraint?.isActive = true
    }
    
    func configure(with memo: MemoModel, isExpanded: Bool = false) {
        titleLabel.text = memo.previewText
        contentTextView.text = memo.content
        
        // 확장 상태 설정 (애니메이션 없음)
        self.isExpanded = isExpanded
        updateExpandedState(animated: false)
    }
    
    func toggleExpanded() {
        isExpanded = !isExpanded
        updateExpandedState(animated: true)
    }
    
    private func updateExpandedState(animated: Bool = true) {
        if isExpanded {
            // 확장 상태
            expandCell(animated: animated)
        } else {
            // 축소 상태
            collapseCell(animated: animated)
        }
    }
    
    private func expandCell(animated: Bool) {
        // 먼저 컨테이너 표시
        contentContainer.isHidden = false
        
        // 높이 제약 조건 비활성화
        containerHeightConstraint?.isActive = false
        
        // 텍스트뷰 제약 조건 활성화
        textViewTopConstraint?.isActive = true
        textViewBottomConstraint?.isActive = true
        
        // 텍스트뷰 내용 기반으로 높이 결정
        let maxHeight: CGFloat = 150
        let sizeToFit = contentTextView.sizeThatFits(CGSize(width: contentTextView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        let contentHeight = min(sizeToFit.height, maxHeight)
        
        // 스크롤 활성화 결정
        contentTextView.isScrollEnabled = sizeToFit.height > maxHeight
        
        // 애니메이션 적용
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
    
    private func collapseCell(animated: Bool) {
        // 텍스트뷰 제약 조건 비활성화
        textViewTopConstraint?.isActive = false
        textViewBottomConstraint?.isActive = false
        
        // 높이 제약 조건 활성화
        containerHeightConstraint?.isActive = true
        
        // 애니메이션 적용
        let animationBlock = {
            self.layoutIfNeeded()
        }
        
        let completionBlock = { (finished: Bool) in
            self.contentContainer.isHidden = true
            self.contentTextView.isScrollEnabled = false
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: animationBlock, completion: completionBlock)
        } else {
            animationBlock()
            completionBlock(true)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 셀 재사용 시 상태 초기화
        isExpanded = false
        contentContainer.isHidden = true
        containerHeightConstraint?.isActive = true
        textViewTopConstraint?.isActive = false
        textViewBottomConstraint?.isActive = false
    }
}

