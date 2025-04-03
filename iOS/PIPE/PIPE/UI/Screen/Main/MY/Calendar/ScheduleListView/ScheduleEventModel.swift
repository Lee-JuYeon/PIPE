//
//  CalendarEventModel.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation

struct ScheduleEventModel: Codable, Equatable, Identifiable {
    let id: UUID
    let title: String
    let date: Date
    let notes: String?
    let color: Int // 이벤트 색상을 Int로 저장 (UIColor를 직접 인코딩 할 수 없음)
    
    init(id: UUID = UUID(), title: String, date: Date, notes: String? = nil, color: Int = 0) {
        self.id = id
        self.title = title
        self.date = date
        self.notes = notes
        self.color = color
    }
    
    // 날짜만 비교 (시간은 무시)
    static func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
