//
//  SavingsCell.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/28.
//

import UIKit
import RxSwift

class MemoHeaderView: UITableViewHeaderFooterView {
    static let identifier = "MemoHeaderView"
    
    // 컨텐츠 관리를 위한 클로저
    var onSaveButtonTap: ((String) -> Void)?
    var onCancelButtonTap: (() -> Void)?
    var onAddButtonTap: (() -> Void)?
    
    // UI 요소
    private let titleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("새 메모 추가", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textViewContainer: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.text = ""
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.backgroundColor = .clear
        return textView
    }()
    
    private var textViewContainerHeightConstraint: NSLayoutConstraint?
    private var textViewTopConstraint: NSLayoutConstraint?
    private var textViewBottomConstraint: NSLayoutConstraint?
    private var isExpanded = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(titleButton)
        contentView.addSubview(textViewContainer)
        textViewContainer.addSubview(textView)
        
        NSLayoutConstraint.activate([
            // 버튼 제약 조건
            titleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // 컨테이너 제약 조건
            textViewContainer.topAnchor.constraint(equalTo: titleButton.bottomAnchor, constant: 12),
            textViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // 텍스트뷰 제약 조건 (별도 저장하여 나중에 활성화/비활성화 가능)
        textViewTopConstraint = textView.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 8)
        textViewBottomConstraint = textView.bottomAnchor.constraint(equalTo: textViewContainer.bottomAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            textViewTopConstraint!,
            textView.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: textViewContainer.trailingAnchor, constant: -8),
            textViewBottomConstraint!
        ])
        
        // 컨테이너 초기 높이 설정 (0으로 시작)
        textViewContainerHeightConstraint = textViewContainer.heightAnchor.constraint(equalToConstant: 0)
        textViewContainerHeightConstraint?.isActive = true
        
        // 컨테이너 하단 여백
        let bottomConstraint = textViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
        
        // 버튼 액션 설정
        titleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 텍스트 변경 감지
        textView.delegate = self
    }
    
    @objc private func buttonTapped() {
        if isExpanded {
            // 현재 확장된 상태
            if textView.text.count == 0 {
                // 텍스트가 없으면 취소
                onCancelButtonTap?()
                collapseView()
            } else {
                // 텍스트가 있으면 저장
                onSaveButtonTap?(textView.text)
                collapseView()
            }
        } else {
            // 현재 접힌 상태 - 확장
            onAddButtonTap?()
            expandView()
        }
    }
    
    func expandView() {
        // 먼저 컨테이너를 표시
        textViewContainer.isHidden = false
        
        // 텍스트뷰 제약 조건 활성화
        textViewTopConstraint?.isActive = true
        textViewBottomConstraint?.isActive = true
        
        // 상태 및 높이 업데이트
        isExpanded = true
        textViewContainerHeightConstraint?.constant = 150
        updateButtonTitle()
        
        // 애니메이션으로 변경 적용
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            self.textView.becomeFirstResponder()
        })
    }
    
    func collapseView() {
        // 먼저 키보드 내림
        textView.resignFirstResponder()
        
        // 버튼 타이틀 업데이트
        titleButton.setTitle("새 메모 추가", for: .normal)
        
        // 컨테이너 높이를 0으로 설정
        textViewContainerHeightConstraint?.constant = 0
        
        // 애니메이션으로 변경 적용
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            // 애니메이션 완료 후 컨테이너 숨김
            self.textViewContainer.isHidden = true
            self.textView.text = ""
            self.isExpanded = false
            
            // 텍스트뷰 제약 조건 비활성화
            self.textViewTopConstraint?.isActive = false
            self.textViewBottomConstraint?.isActive = false
        })
    }
    
    func updateButtonTitle() {
        if isExpanded {
            titleButton.setTitle(textView.text.isEmpty ? "메모 취소" : "메모 저장", for: .normal)
        } else {
            titleButton.setTitle("새 메모 추가", for: .normal)
        }
    }
    
    // 내부 레이아웃 변경 시 호출되는 메서드 재정의
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 높이가 0일 때는 텍스트뷰 제약 조건 비활성화
        if textViewContainerHeightConstraint?.constant == 0 {
            textViewTopConstraint?.isActive = false
            textViewBottomConstraint?.isActive = false
        }
    }
}

extension MemoHeaderView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateButtonTitle()
    }
}
