//
//  CalendarEvent.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//

import Foundation
import CoreData

// CalendarEvent.swift (Core Data 모델)
@objc(CalendarEvent)
public class CalendarEvent: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var notes: String?
    @NSManaged public var colorIndex: Int16
    @NSManaged public var isAllDay: Bool
}

// CalendarEvent.swift에 추가
extension CalendarEvent {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalendarEvent> {
        return NSFetchRequest<CalendarEvent>(entityName: "CalendarEvent")
    }
}
