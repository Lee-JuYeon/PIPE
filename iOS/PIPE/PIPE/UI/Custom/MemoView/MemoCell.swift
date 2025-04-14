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
    private var calendarEvent: CalendarModel? // 캘린더 이벤트 추가
    private let dateFormatter = DateFormatter()
    
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
    
    // 새로 추가: 날짜 표시 레이블
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "" // 기본 텍스트 설정
        return label
    }()
    
    // 이벤트 레이블을 담을 컨테이너 뷰
    private let eventLabelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemBackground.cgColor
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 이벤트 레이블
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(dateLabel) // 날짜 레이블 추가
        contentView.addSubview(eventLabelContainer)
        eventLabelContainer.addSubview(eventLabel)

        
        NSLayoutConstraint.activate([
            // 날짜 레이블 제약조건 - eventLabelContainer 왼쪽에 위치
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentTextView.leadingAnchor, constant: 16),
            
            // 컨테이너 뷰 제약조건
            eventLabelContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            eventLabelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),

            
            // 레이블 제약조건 (패딩 적용)
            eventLabel.topAnchor.constraint(equalTo: eventLabelContainer.topAnchor, constant: 2),
            eventLabel.bottomAnchor.constraint(equalTo: eventLabelContainer.bottomAnchor, constant: -2),
            eventLabel.leadingAnchor.constraint(equalTo: eventLabelContainer.leadingAnchor, constant: 2),
            eventLabel.trailingAnchor.constraint(equalTo: eventLabelContainer.trailingAnchor, constant: -2),
            
            contentTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        // 텍스트뷰 델리게이트 설정
        contentTextView.delegate = self
    }
    
    // MARK: - Configuration
    func configure(with memo: MemoModel, isExpanded: Bool = false) {
        // 중요: UITextView의 사용자 상호작용을 비활성화하여 셀의 선택 이벤트가 제대로 전달되도록 함
        if !isExpanded {
            contentTextView.isUserInteractionEnabled = false
        }

        self.memo = memo
        self.isExpanded = isExpanded
        
        contentTextView.text = memo.content
        
        // 업데이트 날짜가 있으면 업데이트 날짜, 없으면 생성 날짜
        let date = memo.updatedAt ?? memo.createdAt
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateLabel.text = dateFormatter.string(from: date)
        
        // 캘린더 이벤트 설정
        configureCalendarEvent()
        
        // 중요: UITextView의 사용자 상호작용을 비활성화하여 셀의 선택 이벤트가 제대로 전달되도록 함
        contentTextView.isUserInteractionEnabled = isExpanded
        
        // 확장 상태에 따라 표시 방식 변경
        updateExpandedState()
    }
    
    func addEvent(calendarEvent : CalendarModel){
        self.calendarEvent = calendarEvent
        configureCalendarEvent()

    }
    
    // 캘린더 이벤트 정보 구성
    private func configureCalendarEvent() {
//        guard let event = calendarEvent else {
//            return
//        }
//        
//        // 이벤트 표시 포맷: "MM/dd 제목(최대 5자)"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "M/d"
//        let dateString = dateFormatter.string(from: event.startDate)
//        
//        // 타이틀 길이 제한 (최대 5자)
//        let truncatedTitle = event.title.count > 5 ?
//            String(event.title.prefix(5)) : event.title
//                
//        eventLabel.text = "\(dateString) \(truncatedTitle)"
//        eventLabelContainer.backgroundColor = event.color()
        if let event = calendarEvent {
            // 이벤트 표시 포맷: "MM/dd 제목(최대 5자)"
            dateFormatter.dateFormat = "M/d"
            let dateString = dateFormatter.string(from: event.startDate)
            
            // 타이틀 길이 제한 (최대 5자)
            let truncatedTitle = event.title.count > 5 ?
                String(event.title.prefix(5)) : event.title
                    
            eventLabel.text = "\(dateString) \(truncatedTitle)"
            eventLabelContainer.backgroundColor = event.color()
        } else {
            // 이벤트가 없는 경우 기본 텍스트로 설정
            eventLabel.text = "이벤트 없음"
            eventLabelContainer.backgroundColor = .systemGray5
        }
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
            
            
            // 캘린더 이벤트가 있으면 다시 표시
            configureCalendarEvent()
            
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
        
        // 재사용 시 기본 상태로 초기화
        eventLabel.text = "이벤트 없음"
        eventLabelContainer.backgroundColor = .systemGray5
        dateLabel.text = ""
        
        memo = nil
        calendarEvent = nil
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
