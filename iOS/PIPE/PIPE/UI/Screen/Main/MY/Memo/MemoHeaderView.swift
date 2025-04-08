//
//  SavingsCell.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/28.
//
import UIKit

protocol MemoHeaderViewDelegate: AnyObject {
    func memoHeaderViewDidTapAddButton(_ headerView: MemoHeaderView)
    func memoHeaderViewDidTapSaveButton(_ headerView: MemoHeaderView, text: String)
    func memoHeaderViewDidTapCancelButton(_ headerView: MemoHeaderView)
}

class MemoHeaderView: UITableViewHeaderFooterView {
    static let identifier = "MemoHeaderView"
    
    // 델리게이트 패턴으로 통합
    weak var delegate: MemoHeaderViewDelegate?
    
    // UI 요소
    private let titleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("새 메모 추가", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textViewContainer: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.text = ""
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        textView.backgroundColor = .white
        return textView
    }()
    
    private var textViewContainerHeightConstraint: NSLayoutConstraint?
    private var isExpanded = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(titleButton)
        contentView.addSubview(textViewContainer)
        textViewContainer.addSubview(textView)
        
        NSLayoutConstraint.activate([
            // 버튼 제약 조건
            titleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            titleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // 컨테이너 제약 조건
            textViewContainer.topAnchor.constraint(equalTo: titleButton.bottomAnchor, constant: 2),
            textViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            textViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            // 텍스트뷰 제약 조건
            textView.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 2),
            textView.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor, constant: 4),
            textView.trailingAnchor.constraint(equalTo: textViewContainer.trailingAnchor, constant: -4),
            textView.bottomAnchor.constraint(equalTo: textViewContainer.bottomAnchor, constant: -4)
        ])
        
        // 컨테이너 초기 높이 설정 (0으로 시작)
        textViewContainerHeightConstraint = textViewContainer.heightAnchor.constraint(equalToConstant: 0)
        textViewContainerHeightConstraint?.isActive = true
        
        // 컨테이너 하단 여백
        let bottomConstraint = textViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
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
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // 텍스트가 없으면 취소
                delegate?.memoHeaderViewDidTapCancelButton(self)
                collapseView()
            } else {
                // 텍스트가 있으면 저장
                let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
                delegate?.memoHeaderViewDidTapSaveButton(self, text: text)
                collapseView()
            }
        } else {
            // 현재 접힌 상태 - 확장
            delegate?.memoHeaderViewDidTapAddButton(self)
            expandView()
        }
    }
    
    func expandView() {
        // 먼저 컨테이너를 표시
        textViewContainer.isHidden = false
        
        // 상태 및 높이 업데이트
        isExpanded = true
        textViewContainerHeightConstraint?.constant = 150
        updateButtonTitle()
        
        // 애니메이션으로 변경 적용
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.layoutIfNeeded()
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
            self.contentView.layoutIfNeeded()
        }, completion: { _ in
            // 애니메이션 완료 후 컨테이너 숨김
            self.textViewContainer.isHidden = true
            self.textView.text = ""
            self.isExpanded = false
        })
    }
    
    func updateButtonTitle() {
        if isExpanded {
            titleButton.setTitle(textView.text.isEmpty ? "메모 취소" : "메모 저장", for: .normal)
        } else {
            titleButton.setTitle("새 메모 추가", for: .normal)
        }
    }
}

extension MemoHeaderView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateButtonTitle()
    }
}
