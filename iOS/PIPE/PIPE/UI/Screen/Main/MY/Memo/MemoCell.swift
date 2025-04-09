//
//  DepositModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//
import UIKit

class MemoCell: UITableViewCell {
    static let identifier = "MemoCell"
    
    // MARK: - Properties
    private var memo: MemoModel?
    private var isExpanded = false
    weak var delegate: MemoCellDelegate?
    
    // MARK: - UI Components
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        // 셀 설정
        selectionStyle = .default
        backgroundColor = .systemBackground
        
        // TextContainer는 셀 내부에 들어감
        contentView.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // 텍스트뷰 델리게이트 설정
        contentTextView.delegate = self
    }
    
    // MARK: - Configuration
    func configure(with memo: MemoModel, isExpanded: Bool = false) {
        self.memo = memo
        self.isExpanded = isExpanded
        
        contentTextView.text = memo.content
        
        // 중요: UITextView의 사용자 상호작용을 비활성화하여 셀의 선택 이벤트가 제대로 전달되도록 함
        if !isExpanded {
            contentTextView.isUserInteractionEnabled = false
        }
        
        // 확장 상태에 따라 표시 방식 변경
        updateExpandedState()
    }
    
    // MARK: - Toggle Expanded State
    func toggleExpanded() {
        isExpanded = !isExpanded
        updateExpandedState()
    }
    
    private func updateExpandedState() {
        // 텍스트가 있는지 확인
        guard let content = contentTextView.text, !content.isEmpty else {
            contentTextView.text = "빈 메모"
            return
        }
        
        if isExpanded {
            // 확장 상태 - 전체 텍스트 및 편집 가능 상태
            contentTextView.text = content
            contentTextView.isEditable = true
            contentTextView.isUserInteractionEnabled = true // 편집 가능하도록 활성화
            contentTextView.backgroundColor = .systemGray6
            
            DispatchQueue.main.async {
                self.contentTextView.becomeFirstResponder()
            }
        } else {
            // 접힌 상태 - 첫 줄만 표시하고 편집 불가
            let firstLine = content.split(separator: "\n", maxSplits: 1).first ?? Substring(content)
            
            // 글자수가 너무 길면 자르기
            if firstLine.count > 100 {
                let truncatedLine = firstLine.prefix(100) + "..."
                contentTextView.text = String(truncatedLine)
            } else {
                contentTextView.text = String(firstLine)
            }
            
            contentTextView.isEditable = false
            contentTextView.isUserInteractionEnabled = false // 중요: 셀 선택이 가능하도록 비활성화
            contentTextView.resignFirstResponder()
            contentTextView.backgroundColor = .clear
            
            // 텍스트가 변경되었고 메모가 설정되어 있다면 저장
            saveChangesIfNeeded()
        }
    }
    
    private func saveChangesIfNeeded() {
        guard let memo = memo,
              let newContent = contentTextView.text,
              newContent != memo.content else {
            return
        }
        
        // 델리게이트에 내용 변경 알림
        delegate?.memoCellDidEndEditing(self, memo: memo, newContent: newContent)
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        contentTextView.text = nil
        contentTextView.isEditable = false
        contentTextView.isUserInteractionEnabled = false // 중요: 셀 선택이 가능하도록 비활성화
        contentTextView.backgroundColor = .clear
        memo = nil
        isExpanded = false
    }
}

protocol MemoCellDelegate: AnyObject {
    func memoCellDidEndEditing(_ cell: MemoCell, memo: MemoModel, newContent: String)
}

// MARK: - UITextViewDelegate
extension MemoCell: UITextViewDelegate {
    // 텍스트 편집 완료 시 호출
    func textViewDidEndEditing(_ textView: UITextView) {
        saveChangesIfNeeded()
    }
    
    // 리턴 키 처리 (옵션)
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 엔터키를 누르면 줄바꿈 허용 (리턴 키 특수 처리가 필요하면 여기서 구현)
        return true
    }
}
