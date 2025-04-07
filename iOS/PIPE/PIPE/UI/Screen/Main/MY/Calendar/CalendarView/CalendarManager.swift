//
//  CalendarCoreDataManager.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//

import Foundation

// 캘린더 이벤트 변경 통지를 위한 프로토콜
protocol CalendarManagerDelegate: AnyObject {
    func calendarEventsDidUpdate(events: [CalendarModel])
    func calendarEventDidSave(event: CalendarModel, success: Bool)
    func calendarEventDidDelete(eventID: UUID, success: Bool)
    func calendarEventDidUpdate(event: CalendarModel, success: Bool)
}

// 프로토콜의 기본 구현 (선택적으로 구현 가능)
extension CalendarManagerDelegate {
    func calendarEventsDidUpdate(events: [CalendarModel]) {}
    func calendarEventDidSave(event: CalendarModel, success: Bool) {}
    func calendarEventDidDelete(eventID: UUID, success: Bool) {}
    func calendarEventDidUpdate(event: CalendarModel, success: Bool) {}
}

// 캘린더 이벤트 관리 클래스
class CalendarManager {
    // 싱글톤 인스턴스
    static let shared = CalendarManager()
    
    // NotificationCenter를 위한 상수
    struct NotificationNames {
        static let eventsUpdated = Notification.Name("CalendarEventsUpdated")
        static let eventSaved = Notification.Name("CalendarEventSaved")
        static let eventDeleted = Notification.Name("CalendarEventDeleted")
        static let eventUpdated = Notification.Name("CalendarEventUpdated")
    }
    
    // UserDefaults 키
    private let eventsKey = "calendar_events"
    
    // 델리게이트
    weak var delegate: CalendarManagerDelegate?
    
    // 이벤트 캐시
    private var events: [CalendarModel] = []
    
    // 초기화
    private init() {
        loadEvents()
    }
    
    // MARK: - 이벤트 CRUD 메서드
    
    // 이벤트 로드
    private func loadEvents() {
        guard let data = UserDefaults.standard.data(forKey: eventsKey) else {
            events = []
            return
        }
        
        do {
            events = try JSONDecoder().decode([CalendarModel].self, from: data)
        } catch {
            print("이벤트 로드 실패: \(error)")
            events = []
        }
    }
    
    // 이벤트 저장
    private func saveEvents() -> Bool {
        do {
            let data = try JSONEncoder().encode(events)
            UserDefaults.standard.set(data, forKey: eventsKey)
            return true
        } catch {
            print("이벤트 저장 실패: \(error)")
            return false
        }
    }
    
    // 모든 이벤트 조회
    func fetchEvents() -> [CalendarModel] {
        return events
    }
    
    // 특정 날짜 범위의 이벤트 조회
    func fetchEvents(from startDate: Date, to endDate: Date) -> [CalendarModel] {
        return events.filter { event in
            return event.startDate >= startDate && event.startDate <= endDate
        }
    }
    
    // 특정 날짜의 이벤트 조회
    func fetchEvents(for date: Date) -> [CalendarModel] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return events.filter { event in
            return event.startDate >= startOfDay && event.startDate < endOfDay
        }
    }
    
    // 새 이벤트 추가
    func addEvent(title: String,
                 startDate: Date,
                 endDate: Date? = nil,
                 notes: String? = nil,
                 colorIndex: Int = 0,
                 isAllDay: Bool = false,
                 completion: ((Bool) -> Void)? = nil) {
        
        let newEvent = CalendarModel(
            title: title,
            startDate: startDate,
            endDate: endDate,
            notes: notes,
            colorIndex: colorIndex,
            isAllDay: isAllDay
        )
        
        events.append(newEvent)
        let success = saveEvents()
        
        // 델리게이트 및 노티피케이션 호출
        delegate?.calendarEventDidSave(event: newEvent, success: success)
        NotificationCenter.default.post(
            name: NotificationNames.eventSaved,
            object: self,
            userInfo: ["event": newEvent, "success": success]
        )
        
        delegate?.calendarEventsDidUpdate(events: events)
        NotificationCenter.default.post(
            name: NotificationNames.eventsUpdated,
            object: self,
            userInfo: ["events": events]
        )
        
        completion?(success)
    }
    
    // 이벤트 업데이트
    func updateEvent(id: UUID,
                    title: String? = nil,
                    startDate: Date? = nil,
                    endDate: Date? = nil,
                    notes: String? = nil,
                    colorIndex: Int? = nil,
                    isAllDay: Bool? = nil,
                    completion: ((Bool) -> Void)? = nil) {
        
        guard let index = events.firstIndex(where: { $0.id == id }) else {
            completion?(false)
            return
        }
        
        var updatedEvent = events[index]
        
        // 변경할 속성만 업데이트
        if let title = title { updatedEvent.title = title }
        if let startDate = startDate { updatedEvent.startDate = startDate }
        if let endDate = endDate { updatedEvent.endDate = endDate }
        if let notes = notes { updatedEvent.notes = notes }
        if let colorIndex = colorIndex { updatedEvent.colorIndex = colorIndex }
        if let isAllDay = isAllDay { updatedEvent.isAllDay = isAllDay }
        
        events[index] = updatedEvent
        let success = saveEvents()
        
        // 델리게이트 및 노티피케이션 호출
        delegate?.calendarEventDidUpdate(event: updatedEvent, success: success)
        NotificationCenter.default.post(
            name: NotificationNames.eventUpdated,
            object: self,
            userInfo: ["event": updatedEvent, "success": success]
        )
        
        delegate?.calendarEventsDidUpdate(events: events)
        NotificationCenter.default.post(
            name: NotificationNames.eventsUpdated,
            object: self,
            userInfo: ["events": events]
        )
        
        completion?(success)
    }
    
    // 이벤트 삭제
    func deleteEvent(id: UUID, completion: ((Bool) -> Void)? = nil) {
        guard let index = events.firstIndex(where: { $0.id == id }) else {
            completion?(false)
            return
        }
        
        let deletedEvent = events[index]
        events.remove(at: index)
        let success = saveEvents()
        
        // 델리게이트 및 노티피케이션 호출
        delegate?.calendarEventDidDelete(eventID: id, success: success)
        NotificationCenter.default.post(
            name: NotificationNames.eventDeleted,
            object: self,
            userInfo: ["eventID": id, "success": success]
        )
        
        delegate?.calendarEventsDidUpdate(events: events)
        NotificationCenter.default.post(
            name: NotificationNames.eventsUpdated,
            object: self,
            userInfo: ["events": events]
        )
        
        completion?(success)
    }
    
    // 이벤트 검색
    func findEvent(byID id: UUID) -> CalendarModel? {
        return events.first { $0.id == id }
    }
    
    // 모든 이벤트 삭제 (리셋)
    func clearAllEvents(completion: ((Bool) -> Void)? = nil) {
        events = []
        let success = saveEvents()
        
        delegate?.calendarEventsDidUpdate(events: [])
        NotificationCenter.default.post(
            name: NotificationNames.eventsUpdated,
            object: self,
            userInfo: ["events": []]
        )
        
        completion?(success)
    }
}
