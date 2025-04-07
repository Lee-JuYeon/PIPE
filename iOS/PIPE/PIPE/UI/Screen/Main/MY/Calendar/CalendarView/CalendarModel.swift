//
//  CalendarEvent.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//


import Foundation
import UIKit

// 캘린더 이벤트 모델 (Codable로 구현하여 UserDefaults 저장 가능)
struct CalendarModel: Codable, Identifiable, Hashable {
    // 기본 속성
    var id: UUID
    var title: String
    var startDate: Date
    var endDate: Date?
    var notes: String?
    var colorIndex: Int
    var isAllDay: Bool
    
    // 초기화
    init(id: UUID = UUID(),
         title: String,
         startDate: Date,
         endDate: Date? = nil,
         notes: String? = nil,
         colorIndex: Int = 0,
         isAllDay: Bool = false) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate ?? startDate
        self.notes = notes
        self.colorIndex = colorIndex
        self.isAllDay = isAllDay
    }
    
    // 편의 속성들
    
    // 이벤트 타이틀 (없으면 '(제목 없음)')
    var displayTitle: String {
        return title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
            "(제목 없음)" : title
    }
    
    // 오늘 이벤트인지 확인
    var isToday: Bool {
        return Calendar.current.isDateInToday(startDate)
    }
    
    // 미래 이벤트인지 확인
    var isFuture: Bool {
        return startDate > Date()
    }
    
    // 과거 이벤트인지 확인
    var isPast: Bool {
        return startDate < Date()
    }
    
    // 유틸리티 메서드
    
    // 날짜 포맷팅
    func formattedStartDate(format: String = "yyyy.MM.dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: startDate)
    }
    
    func formattedEndDate(format: String = "yyyy.MM.dd HH:mm") -> String {
        guard let endDate = endDate else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: endDate)
    }
    
    // 이벤트 기간 표시 문자열
    func formattedDateRange() -> String {
        if isAllDay {
            // 종일 이벤트
            if let end = endDate, !Calendar.current.isDate(startDate, inSameDayAs: end) {
                return "\(formattedStartDate(format: "yyyy.MM.dd")) ~ \(formattedEndDate(format: "yyyy.MM.dd"))"
            } else {
                return formattedStartDate(format: "yyyy.MM.dd") + " (종일)"
            }
        } else {
            // 시간 지정 이벤트
            if let end = endDate, !Calendar.current.isDate(startDate, inSameDayAs: end) {
                return "\(formattedStartDate()) ~ \(formattedEndDate())"
            } else {
                return "\(formattedStartDate(format: "yyyy.MM.dd HH:mm")) ~ \(formattedEndDate(format: "HH:mm"))"
            }
        }
    }
    
    // 이벤트 색상 - UIColor는 Codable이 아니므로 colorIndex를 사용하여 반환
    func color() -> UIColor {
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
}
