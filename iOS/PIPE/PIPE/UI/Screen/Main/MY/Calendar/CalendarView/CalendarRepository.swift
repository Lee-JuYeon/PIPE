//
//  CalendarRepository.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//

import Foundation

protocol CalendarRepositoryDelegate: AnyObject {
    func didUpdateEvents(events: [CalendarModel])
    func didSaveEvent(event: CalendarModel, success: Bool)
    func didDeleteEvent(eventID: UUID, success: Bool)
    func didUpdateEvent(event: CalendarModel, success: Bool)
}

extension CalendarRepositoryDelegate {
    func didUpdateEvents(events: [CalendarModel]) {}
    func didSaveEvent(event: CalendarModel, success: Bool) {}
    func didDeleteEvent(eventID: UUID, success: Bool) {}
    func didUpdateEvent(event: CalendarModel, success: Bool) {}
}

class CalendarRepository {
    
    private let calendarManager: CalendarManager
    weak var delegate: CalendarRepositoryDelegate?
    
    init(calendarManager: CalendarManager = .shared) {
        self.calendarManager = calendarManager
        
        // NotificationCenter 옵저버 등록
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        // 이벤트 목록 업데이트 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventsUpdated(_:)),
            name: CalendarManager.NotificationNames.eventsUpdated,
            object: nil
        )
        
        // 이벤트 저장 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventSaved(_:)),
            name: CalendarManager.NotificationNames.eventSaved,
            object: nil
        )
        
        // 이벤트 삭제 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventDeleted(_:)),
            name: CalendarManager.NotificationNames.eventDeleted,
            object: nil
        )
        
        // 이벤트 업데이트 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventUpdated(_:)),
            name: CalendarManager.NotificationNames.eventUpdated,
            object: nil
        )
    }
    
    // 알림 처리 메서드들
    @objc private func handleEventsUpdated(_ notification: Notification) {
        if let events = notification.userInfo?["events"] as? [CalendarModel] {
            delegate?.didUpdateEvents(events: events)
        }
    }
    
    @objc private func handleEventSaved(_ notification: Notification) {
        if let event = notification.userInfo?["event"] as? CalendarModel,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didSaveEvent(event: event, success: success)
        }
    }
    
    @objc private func handleEventDeleted(_ notification: Notification) {
        if let eventID = notification.userInfo?["eventID"] as? UUID,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didDeleteEvent(eventID: eventID, success: success)
        }
    }
    
    @objc private func handleEventUpdated(_ notification: Notification) {
        if let event = notification.userInfo?["event"] as? CalendarModel,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didUpdateEvent(event: event, success: success)
        }
    }
    
    deinit {
        // 메모리에서 해제될 때 옵저버 제거
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 공개 API
    
    // 모든 이벤트 목록 가져오기
    func fetchEvents() -> [CalendarModel] {
        return calendarManager.fetchEvents()
    }
    
    // 특정 날짜 범위의 이벤트 가져오기
    func fetchEvents(from startDate: Date, to endDate: Date) -> [CalendarModel] {
        return calendarManager.fetchEvents(from: startDate, to: endDate)
    }
    
    // 특정 날짜의 이벤트 가져오기
    func fetchEvents(for date: Date) -> [CalendarModel] {
        return calendarManager.fetchEvents(for: date)
    }
    
    // 이벤트 저장하기
    func saveEvent(title: String,
                   startDate: Date,
                   endDate: Date? = nil,
                   notes: String? = nil,
                   colorIndex: Int = 0,
                   isAllDay: Bool = false,
                   completion: ((Bool) -> Void)? = nil) {
        calendarManager.addEvent(
            title: title,
            startDate: startDate,
            endDate: endDate,
            notes: notes,
            colorIndex: colorIndex,
            isAllDay: isAllDay,
            completion: completion
        )
    }
    
    // 이벤트 업데이트하기
    func updateEvent(id: UUID,
                     title: String? = nil,
                     startDate: Date? = nil,
                     endDate: Date? = nil,
                     notes: String? = nil,
                     colorIndex: Int? = nil,
                     isAllDay: Bool? = nil,
                     completion: ((Bool) -> Void)? = nil) {
        calendarManager.updateEvent(
            id: id,
            title: title,
            startDate: startDate,
            endDate: endDate,
            notes: notes,
            colorIndex: colorIndex,
            isAllDay: isAllDay,
            completion: completion
        )
    }
    
    // 이벤트 삭제하기
    func deleteEvent(id: UUID, completion: ((Bool) -> Void)? = nil) {
        calendarManager.deleteEvent(id: id, completion: completion)
    }
    
    // ID로 이벤트 찾기
    func findEvent(byID id: UUID) -> CalendarModel? {
        return calendarManager.findEvent(byID: id)
    }
    
    // 모든 이벤트 삭제
    func clearAllEvents(completion: ((Bool) -> Void)? = nil) {
        calendarManager.clearAllEvents(completion: completion)
    }
}
