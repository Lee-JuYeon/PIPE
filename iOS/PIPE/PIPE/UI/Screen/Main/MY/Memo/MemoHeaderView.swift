//
//  SavingsCell.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/28.
//
import UIKit
import RxSwift

class MemoHeaderView: UITableViewHeaderFooterView, UITextViewDelegate {
    static let identifier = "MemoHeaderView"
    
    // 컨텐츠 관리를 위한 클로저
    var onSaveButtonTap: ((String) -> Void)?
    var onCancelButtonTap: (() -> Void)?
    var onAddButtonTap: (() -> Void)?
    var onTextChanged: ((String) -> Void)?
    
    // UI 요소
    let titleButton: UIButton = {
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
        textView.text = "" // 명시적으로 빈 문자열로 초기화
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
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
        contentView.addSubview(textViewContainer)
        contentView.addSubview(titleButton)
        textViewContainer.addSubview(textView)
        
        NSLayoutConstraint.activate([
            // titleButton은 항상 상단에 고정되도록 설정
            titleButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            // textViewContainer는 titleButton 아래에 배치
            textViewContainer.topAnchor.constraint(equalTo: titleButton.bottomAnchor, constant: 12),
            textViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            // textView 제약 조건
            textView.topAnchor.constraint(equalTo: textViewContainer.topAnchor),
            textView.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: textViewContainer.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: textViewContainer.bottomAnchor),
        ])
        
        // 초기 높이 제약 (0으로 설정하여 숨김)
        textViewContainerHeightConstraint = textViewContainer.heightAnchor.constraint(equalToConstant: 0)
        textViewContainerHeightConstraint?.isActive = true
        
        // 버튼 액션 설정
        titleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 텍스트 변경 감지
        textView.delegate = self
    }
    
    @objc private func buttonTapped() {
        if isExpanded {
            // 확장된 상태
            if textView.text.count == 0 {
                // 텍스트가 비어있으면 취소
                onCancelButtonTap?()
                animateView() // 직접 축소 메서드 호출 추가
            } else {
                // 텍스트가 있으면 저장
                onSaveButtonTap?(textView.text)
            }
        } else {
            // 접힌 상태 - 확장
            onAddButtonTap?()
        }
    }
    
    // expandView 함수에서 초기 텍스트 설정
    func animateView() {
        if isExpanded { // collapse
            isExpanded = false
            textViewContainerHeightConstraint?.constant = 0 // 축소 시 높이
            titleButton.setTitle("새 메모 추가", for: .normal)
            textView.resignFirstResponder()
            textView.text = ""
            
            // 애니메이션
            UIView.animate(withDuration: 0.3, animations: {
                self.contentView.layoutIfNeeded()
            }) { _ in
                self.textViewContainer.isHidden = true
            }
        }else { // expanded
            isExpanded = true
            textViewContainer.isHidden = false
            textViewContainerHeightConstraint?.constant = 150 // 확장 시 높이
            textView.text = "" // 명시적으로 빈 문자열로 초기화
            updateButtonTitle() // 버튼 제목 업데이트
            textView.becomeFirstResponder()
            
            // 애니메이션
            UIView.animate(withDuration: 0.3) {
                self.contentView.layoutIfNeeded()
            }
        }
    }
    
    
    func updateButtonTitle() {
        print("Memo, MemoHeaderView // 텍스트 길이: \(textView.text.count)") // 길이 확인용 로깅
        if isExpanded {
            let newTitle = textView.text.count == 0 ? "메모 취소" : "메모 저장"
            print("Memo, MemoHeaderView // 버튼 타이틀 설정: \(newTitle)")
            titleButton.setTitle(newTitle, for: .normal)
        } else {
            titleButton.setTitle("새 메모 추가", for: .normal)
        }
    }
    
    func getText() -> String {
        return textView.text
    }
    
    func clearText() {
        textView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateButtonTitle()
        onTextChanged?(textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateButtonTitle()
    }
}
