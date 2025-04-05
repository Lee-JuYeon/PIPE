//
//  CalendarViewModel.swift
//  PIPE
//
//  Created by Jupond on 4/4/25.
//

import Foundation
protocol CalendarViewModelDelegate: AnyObject {
    func didUpdateEvents(events: [CalendarEvent])
    func didCompleteEventOperation(success: Bool, operationType: CalendarViewModel.OperationType)
    func didChangeMonth(date: Date) // 월 변경 이벤트를 알리기 위한 메서드 추가
}

class CalendarViewModel {
    enum OperationType {
        case fetch
        case save
        case update
        case delete
    }
    
    private let repository: CalendarRepository
    private var events: [CalendarEvent] = []
    private var selectedDate: Date = Date()
    private var currentMonth: Date = Date() // 현재 표시 중인 월
    
    weak var delegate: CalendarViewModelDelegate?
    
    init(repository: CalendarRepository = CalendarRepository()) {
        self.repository = repository
        self.repository.delegate = self
        self.currentMonth = Date() // 초기값은 현재 일자
    }
    
    // MARK: - 공개 메서드
    
    // 현재 선택된 날짜 설정
    func setSelectedDate(_ date: Date) {
        selectedDate = date
        delegate?.didUpdateEvents(events: getEventsForSelectedDate())
    }
    
    // 선택된 날짜의 이벤트 조회
    func getEventsForSelectedDate() -> [CalendarEvent] {
        let calendar = Calendar.current
        
        // 날짜만 비교 (시간 무시)
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return events.filter { event in
            guard let eventDate = event.startDate else { return false }
            return eventDate >= startOfDay && eventDate < endOfDay
        }
    }
    
    // 월별 이벤트 조회
    func fetchEventsForMonth(_ date: Date) {
        let calendar = Calendar.current
        
        // 선택된 달의 시작과 끝 날짜
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let startOfMonth = calendar.date(from: components),
              let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth),
              let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth) else {
            return
        }
        
        // 현재 월 업데이트
        currentMonth = startOfMonth
        
        events = repository.fetchEvents(from: startOfMonth, to: endOfMonth)
        delegate?.didUpdateEvents(events: events)
        delegate?.didChangeMonth(date: currentMonth)
    }
    
    // 모든 이벤트 조회
    func fetchAllEvents() {
        events = repository.fetchEvents()
        delegate?.didUpdateEvents(events: events)
    }
    
    // 특정 날짜의 이벤트 존재 여부
    func hasEvents(for date: Date) -> Bool {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return events.contains { event in
            guard let eventDate = event.startDate else { return false }
            return eventDate >= startOfDay && eventDate < endOfDay
        }
    }
    
    // 특정 날짜의 이벤트 목록
    func getEvents(for date: Date) -> [CalendarEvent] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return events.filter { event in
            guard let eventDate = event.startDate else { return false }
            return eventDate >= startOfDay && eventDate < endOfDay
        }
    }
    
    // 이벤트 추가
    func addEvent(title: String, date: Date, notes: String? = nil, colorIndex: Int = 0, isAllDay: Bool = false) {
        repository.saveEvent(
            title: title,
            startDate: date,
            notes: notes,
            colorIndex: colorIndex,
            isAllDay: isAllDay
        ) { [weak self] success in
            self?.delegate?.didCompleteEventOperation(success: success, operationType: .save)
            
            // 이벤트 추가 후 현재 월의 이벤트 다시 불러오기
            if success, let self = self {
                self.fetchEventsForMonth(self.currentMonth)
            }
        }
    }
    
    // 이벤트 수정
    func updateEvent(_ event: CalendarEvent) {
        repository.updateEvent(event) { [weak self] success in
            self?.delegate?.didCompleteEventOperation(success: success, operationType: .update)
            
            // 이벤트 수정 후 현재 월의 이벤트 다시 불러오기
            if success, let self = self {
                self.fetchEventsForMonth(self.currentMonth)
            }
        }
    }
    
    // 이벤트 삭제
    func deleteEvent(_ event: CalendarEvent) {
        repository.deleteEvent(event) { [weak self] success in
            self?.delegate?.didCompleteEventOperation(success: success, operationType: .delete)
            
            // 이벤트 삭제 후 현재 월의 이벤트 다시 불러오기
            if success, let self = self {
                self.fetchEventsForMonth(self.currentMonth)
            }
        }
    }
    
    // MARK: - 월 이동 관련 메서드
    
    // 현재 표시 중인 달 가져오기
    func getCurrentMonth() -> Date {
        return currentMonth
    }
    
    // 이전 달로 이동
    func goToPreviousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) {
            fetchEventsForMonth(newDate)
        }
    }
    
    // 다음 달로 이동
    func goToNextMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) {
            fetchEventsForMonth(newDate)
        }
    }
    
    // 오늘이 있는 달로 이동
    func goToToday() {
        let today = Date()
        fetchEventsForMonth(today)
        setSelectedDate(today)
    }
    
    // 현재 월의 포맷된 문자열 반환 (예: "2025년 4월")
    func getFormattedMonthString(format: String = "yyyy년 MM월") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: currentMonth)
    }
}

// MARK: - CalendarRepositoryDelegate
extension CalendarViewModel: CalendarRepositoryDelegate {
    func didUpdateEvents(events: [CalendarEvent]) {
        self.events = events
        delegate?.didUpdateEvents(events: events)
    }
    
    func didSaveEvent(event: CalendarEvent, success: Bool) {
        delegate?.didCompleteEventOperation(success: success, operationType: .save)
    }
    
    func didDeleteEvent(eventID: UUID?, success: Bool) {
        delegate?.didCompleteEventOperation(success: success, operationType: .delete)
    }
    
    func didUpdateEvent(event: CalendarEvent, success: Bool) {
        delegate?.didCompleteEventOperation(success: success, operationType: .update)
    }
}
