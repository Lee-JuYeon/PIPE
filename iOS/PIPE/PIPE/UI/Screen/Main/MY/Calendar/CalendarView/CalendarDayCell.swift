//
//  CalendarDayCell.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit

class CalendarDayCell: UICollectionViewCell {
    static let identifier = "CalendarDayCell"
    
    // 셀 내부 UI 요소
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 셀 상태
    var date: Date?
    var eventColor: UIColor?
    var isCurrentMonth: Bool = true
    var isToday: Bool = false
    var weekday: Int = 0
    var eventCount: Int = 0
    var isDateSelected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(eventIndicator)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 20),
            
            eventIndicator.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            eventIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventIndicator.widthAnchor.constraint(equalToConstant: 6),
            eventIndicator.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    func configure(date: Date, isCurrentMonth: Bool, isToday: Bool, events: [ScheduleEventModel] = [], weekday: Int, isSelected: Bool = false) {
        self.date = date
        self.isCurrentMonth = isCurrentMonth
        self.isToday = isToday
        self.weekday = weekday
        self.isDateSelected = isSelected
        
        let day = Calendar.current.component(.day, from: date)
        dayLabel.text = "\(day)"
        
        eventCount = events.count
        
        if let firstEvent = events.first {
            let color = getColorForEvent(colorIndex: firstEvent.color)
            eventColor = color
            eventIndicator.backgroundColor = color
            eventIndicator.isHidden = false
        } else {
            eventColor = nil
            eventIndicator.isHidden = true
        }
        
        updateDayLabelColor()
        updateBackgroundColor()
    }
    
    private func updateDayLabelColor() {
        if !isCurrentMonth {
            // 현재 달이 아닌 경우 회색 처리
            dayLabel.textColor = .tertiaryLabel
            return
        }
        
        if isToday {
            // 오늘인 경우 굵은 글씨로 처리
            dayLabel.font = UIFont.boldSystemFont(ofSize: 18)
            dayLabel.textColor = .black
            return
        }
        
        // 주말 색상 처리
        switch weekday {
        case 0: // 일요일
            dayLabel.textColor = .systemRed
        case 6: // 토요일
            dayLabel.textColor = .systemBlue
        default: // 평일
            dayLabel.textColor = .label
        }
        
        // 기본 폰트 설정
        dayLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    private func updateBackgroundColor() {
        if isDateSelected {
            // 선택된 날짜는 연한 회색 배경
            contentView.backgroundColor = .systemGray6
            return
        }
        
        if isToday {
            // 오늘은 연한 회색 배경
            contentView.backgroundColor = .systemGray6
            return
        }
        
        contentView.backgroundColor = .systemBackground
    }
    
    // 이벤트 색상 인덱스로부터 UIColor 생성
    private func getColorForEvent(colorIndex: Int) -> UIColor {
        switch colorIndex {
        case 0: return .systemBlue
        case 1: return .systemRed
        case 2: return .systemGreen
        case 3: return .systemOrange
        case 4: return .systemPurple
        case 5: return .systemTeal
        default: return .systemBlue
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        dayLabel.textColor = .label
        dayLabel.font = UIFont.systemFont(ofSize: 15)
        eventIndicator.isHidden = true
        isToday = false
        isCurrentMonth = true
        date = nil
        contentView.backgroundColor = .systemBackground
    }
}
