//
//  CalendarRepository.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//

// CalendarRepository.swift
import Foundation

protocol CalendarRepositoryDelegate: AnyObject {
    func didUpdateEvents(events: [CalendarEvent])
    func didSaveEvent(event: CalendarEvent, success: Bool)
    func didDeleteEvent(eventID: UUID?, success: Bool)
    func didUpdateEvent(event: CalendarEvent, success: Bool)
}

extension CalendarRepositoryDelegate {
    func didUpdateEvents(events: [CalendarEvent]) {}
    func didSaveEvent(event: CalendarEvent, success: Bool) {}
    func didDeleteEvent(eventID: UUID?, success: Bool) {}
    func didUpdateEvent(event: CalendarEvent, success: Bool) {}
}

class CalendarRepository {
    
    private let coreDataManager: CalendarCoreDataManager
    weak var delegate: CalendarRepositoryDelegate?
    
    init(coreDataManager: CalendarCoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        
        // NotificationCenter 옵저버 등록
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        // 이벤트 목록 업데이트 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventsUpdated(_:)),
            name: CalendarCoreDataManager.NotificationNames.eventsUpdated,
            object: nil
        )
        
        // 이벤트 저장 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventSaved(_:)),
            name: CalendarCoreDataManager.NotificationNames.eventSaved,
            object: nil
        )
        
        // 이벤트 삭제 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventDeleted(_:)),
            name: CalendarCoreDataManager.NotificationNames.eventDeleted,
            object: nil
        )
        
        // 이벤트 업데이트 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventUpdated(_:)),
            name: CalendarCoreDataManager.NotificationNames.eventUpdated,
            object: nil
        )
    }
    
    // 알림 처리 메서드들
    @objc private func handleEventsUpdated(_ notification: Notification) {
        if let events = notification.userInfo?["events"] as? [CalendarEvent] {
            delegate?.didUpdateEvents(events: events)
        }
    }
    
    @objc private func handleEventSaved(_ notification: Notification) {
        if let event = notification.userInfo?["event"] as? CalendarEvent,
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
        if let event = notification.userInfo?["event"] as? CalendarEvent,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didUpdateEvent(event: event, success: success)
        }
    }
    
    deinit {
        // 메모리에서 해제될 때 옵저버 제거
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public API
    
    // 이벤트 목록 가져오기
    func fetchEvents() -> [CalendarEvent] {
        return coreDataManager.fetchEvents()
    }
    
    // 특정 날짜 범위의 이벤트 가져오기
    func fetchEvents(from startDate: Date, to endDate: Date) -> [CalendarEvent] {
        return coreDataManager.fetchEvents(from: startDate, to: endDate)
    }
    
    // 이벤트 저장하기
    func saveEvent(title: String,
                   startDate: Date,
                   endDate: Date? = nil,
                   notes: String? = nil,
                   colorIndex: Int = 0,
                   isAllDay: Bool = false,
                   completion: ((Bool) -> Void)? = nil) {
        coreDataManager.saveEvent(
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
    func updateEvent(_ event: CalendarEvent, completion: ((Bool) -> Void)? = nil) {
        coreDataManager.updateEvent(event, completion: completion)
    }
    
    // 이벤트 삭제하기
    func deleteEvent(_ event: CalendarEvent, completion: ((Bool) -> Void)? = nil) {
        coreDataManager.deleteEvent(event, completion: completion)
    }
}
