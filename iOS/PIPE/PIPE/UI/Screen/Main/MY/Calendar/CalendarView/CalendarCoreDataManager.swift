//
//  CalendarCoreDataManager.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//

import CoreData
import Foundation

class CalendarCoreDataManager {
    static let shared = CalendarCoreDataManager()
    
    // NotificationCenter 관련 상수 정의
    struct NotificationNames {
        static let eventsUpdated = Notification.Name("CalendarEventsUpdated")
        static let eventSaved = Notification.Name("CalendarEventSaved")
        static let eventDeleted = Notification.Name("CalendarEventDeleted")
        static let eventUpdated = Notification.Name("CalendarEventUpdated")
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalendarModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data 저장소 로드 실패: \(error)")
            }
        }
        return container
    }()
    
    private init() {}
    
    // MARK: - Core Data 컨텍스트
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - 이벤트 CRUD 메서드
    
    // 이벤트 조회
    func fetchEvents() -> [CalendarEvent] {
        let fetchRequest: NSFetchRequest<CalendarEvent> = CalendarEvent.fetchRequest()
        
        do {
            let events = try context.fetch(fetchRequest)
            
            // 조회 결과 알림 발송
            NotificationCenter.default.post(
                name: NotificationNames.eventsUpdated,
                object: self,
                userInfo: ["events": events]
            )
            
            return events
        } catch {
            print("이벤트 조회 에러: \(error)")
            return []
        }
    }
    
    // 특정 날짜 범위의 이벤트 조회
    func fetchEvents(from startDate: Date, to endDate: Date) -> [CalendarEvent] {
        let fetchRequest: NSFetchRequest<CalendarEvent> = CalendarEvent.fetchRequest()
        
        // 날짜 범위 조건 추가
        let startPredicate = NSPredicate(format: "startDate >= %@", startDate as NSDate)
        let endPredicate = NSPredicate(format: "startDate <= %@", endDate as NSDate)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startPredicate, endPredicate])
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("날짜 범위 이벤트 조회 에러: \(error)")
            return []
        }
    }
    
    // 이벤트 추가
    func saveEvent(title: String,
                   startDate: Date,
                   endDate: Date? = nil,
                   notes: String? = nil,
                   colorIndex: Int = 0,
                   isAllDay: Bool = false,
                   completion: ((Bool) -> Void)? = nil) {
        
        let event = CalendarEvent(context: context)
        event.id = UUID()
        event.title = title
        event.startDate = startDate
        event.endDate = endDate ?? startDate
        event.notes = notes
        event.colorIndex = Int16(colorIndex)
        event.isAllDay = isAllDay
        
        do {
            try context.save()
            
            // 저장 결과 알림 발송
            NotificationCenter.default.post(
                name: NotificationNames.eventSaved,
                object: self,
                userInfo: ["event": event, "success": true]
            )
            
            // 이벤트 목록 업데이트 알림
            NotificationCenter.default.post(
                name: NotificationNames.eventsUpdated,
                object: self,
                userInfo: ["events": fetchEvents()]
            )
            
            completion?(true)
        } catch {
            print("이벤트 저장 에러: \(error)")
            completion?(false)
        }
    }
    
    // 이벤트 수정
    func updateEvent(_ event: CalendarEvent, completion: ((Bool) -> Void)? = nil) {
        do {
            try context.save()
            
            // 업데이트 결과 알림 발송
            NotificationCenter.default.post(
                name: NotificationNames.eventUpdated,
                object: self,
                userInfo: ["event": event, "success": true]
            )
            
            // 이벤트 목록 업데이트 알림
            NotificationCenter.default.post(
                name: NotificationNames.eventsUpdated,
                object: self,
                userInfo: ["events": fetchEvents()]
            )
            
            completion?(true)
        } catch {
            print("이벤트 업데이트 에러: \(error)")
            completion?(false)
        }
    }
    
    // 이벤트 삭제
    func deleteEvent(_ event: CalendarEvent, completion: ((Bool) -> Void)? = nil) {
        let eventID = event.id
        
        context.delete(event)
        
        do {
            try context.save()
            
            // 삭제 결과 알림 발송
            NotificationCenter.default.post(
                name: NotificationNames.eventDeleted,
                object: self,
                userInfo: ["eventID": eventID as Any, "success": true]
            )
            
            // 이벤트 목록 업데이트 알림
            NotificationCenter.default.post(
                name: NotificationNames.eventsUpdated,
                object: self,
                userInfo: ["events": fetchEvents()]
            )
            
            completion?(true)
        } catch {
            print("이벤트 삭제 에러: \(error)")
            completion?(false)
        }
    }
}
