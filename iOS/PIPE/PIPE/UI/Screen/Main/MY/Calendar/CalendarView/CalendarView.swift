//
//  CalendarView.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit

class CalendarView: UIView {
    
    // MARK: - 속성
    private let calendar = Calendar.current
    private var currentDate = Date()
    private var selectedDate: Date?
    
    // 달력 데이터
    private var days: [Date] = []
    private var eventsByDate: [Date: [ScheduleEventModel]] = [:]
    
    // 선택된 날짜의 이벤트 목록
    private var selectedDateEvents: [ScheduleEventModel] = []
    
    // 이벤트 캐시
    private var eventsCache: [ScheduleEventModel] = []
    
    // 날짜 선택 콜백
    var onDateSelected: ((Date, [ScheduleEventModel]) -> Void)?
    
    // MARK: - UI 요소
    private lazy var calendarView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        // 헤더 사이즈 설정
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        
        // 데이 셀 등록
        cv.register(CalendarDayCell.self, forCellWithReuseIdentifier: CalendarDayCell.identifier)
        
        // 헤더 뷰 등록
        cv.register(
            CalendarHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CalendarHeaderView"
        )
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        backgroundColor = .systemBackground
        
        // 컬렉션 뷰가 자체적으로 사이즈를 결정하지 않도록 설정
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // 필요한 경우 초기 레이아웃 계산을 위한 콜백 등록
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - 공개 메서드
    
    /// 날짜 설정 및 달력 리로드
    func setDate(_ date: Date) {
        currentDate = date
        reloadCalendar()
    }
    
    /// 현재 표시 중인 날짜 반환
    func getCurrentDate() -> Date {
        return currentDate
    }
    
    /// 현재 선택된 날짜 반환
    func getSelectedDate() -> Date? {
        return selectedDate
    }
    
    /// 이벤트 설정
    func setEvents(_ events: [ScheduleEventModel]) {
        eventsCache = events
        reloadCalendar()
    }
    
    /// 현재 이벤트 목록 반환
    func getEvents() -> [ScheduleEventModel] {
        return eventsCache
    }
    
    /// 선택된 날짜 설정
    func setSelectedDate(_ date: Date?) {
        selectedDate = date
        if let date = date {
            updateEventTable(for: date)
        }
        calendarView.reloadData()
    }
    
    /// 특정 날짜의 이벤트 가져오기
    func getEventsForDate(_ date: Date) -> [ScheduleEventModel] {
        return eventsCache.filter { isSameDay(date1: $0.date, date2: date) }
    }
    
    /// 현재 월의 모든 날짜 가져오기
    func getDaysInCurrentMonth() -> [Date] {
        return days
    }
    
    /// 달력 새로고침
    func reloadCalendar() {
        // 날짜 데이터 가져오기
        days = daysInMonth(date: currentDate)
        eventsByDate = getEventsGroupedByDate(for: currentDate)
        
        // 컬렉션 뷰 레이아웃 업데이트
        updateCollectionViewLayout()
        
        // 컬렉션 뷰 리로드
        calendarView.reloadData()
        
        // 자동 높이 갱신
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - 자동 높이 계산
    override var intrinsicContentSize: CGSize {
        // 내부 콘텐츠에 기반한 크기 계산
        let width = UIView.noIntrinsicMetric
        let height = calculateCalendarHeight()
        return CGSize(width: width, height: height)
    }

    private func calculateCalendarHeight() -> CGFloat {
        // 헤더(요일 표시) 높이
        let headerHeight: CGFloat = 30
        
        // 현재 월의 행 수 계산 (보통 5-6주)
        let numberOfWeeks = ceil(Double(days.count) / 7.0)
        
        // 가로/세로 비율을 고려한 셀 높이 계산
        let cellWidth = frame.width / 7
        let cellHeight = cellWidth // 정사각형 셀로 가정
        
        // 총 높이 = 헤더 + (주 수 * 셀 높이)
        return headerHeight + (CGFloat(numberOfWeeks) * cellHeight)
    }

    // 레이아웃 변경 호출, 변경 자동 높이 갱신
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionViewLayout()
        
        // 레이아웃 변경 후 intrinsicContentSize 갱신 알림
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - 내부 헬퍼 메서드
    
    /// 현재 달의 모든 날짜 가져오기 (현재 달 + 이전/다음 달 일부)
    private func daysInMonth(date: Date) -> [Date] {
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        
        var days = [Date]()
        for day in 1...range.count {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        
        // 첫 주의 이전 달 날짜 추가
        let firstWeekday = calendar.component(.weekday, from: days.first!) - 1 // Calendar 요일: 1(일) ~ 7(토)
        if firstWeekday > 0 {
            for i in 0..<firstWeekday {
                if let date = calendar.date(byAdding: .day, value: -i - 1, to: days.first!) {
                    days.insert(date, at: 0)
                }
            }
        }
        
        // 마지막 주의 다음 달 날짜 추가 (총 셀 수가 42개가 되게 - 6주)
        while days.count < 42 {
            if let date = calendar.date(byAdding: .day, value: 1, to: days.last!) {
                days.append(date)
            }
        }
        
        return days
    }
    
    /// 날짜가 현재 달에 속하는지 확인
    private func isDateInCurrentMonth(date: Date, currentMonth: Date) -> Bool {
        let comp1 = calendar.dateComponents([.year, .month], from: date)
        let comp2 = calendar.dateComponents([.year, .month], from: currentMonth)
        return comp1.year == comp2.year && comp1.month == comp2.month
    }
    
    /// 오늘 날짜인지 확인
    private func isToday(date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }
    
    /// 두 날짜가 같은 날인지 확인
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    /// 날짜 형식 설정
    private func formatDate(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// 월 이름 가져오기
    private func monthName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    /// 날짜에서 일(day) 구하기
    private func dayFromDate(_ date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    /// 날짜에 대한 이벤트 그룹 생성
    private func getEventsGroupedByDate(for date: Date) -> [Date: [ScheduleEventModel]] {
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return [:]
        }
        
        var eventsByDate: [Date: [ScheduleEventModel]] = [:]
        
        for day in 1...range.count {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                let dayEvents = getEventsForDate(date)
                if !dayEvents.isEmpty {
                    eventsByDate[date] = dayEvents
                }
            }
        }
        
        return eventsByDate
    }
    
    // 컬렉션 뷰 레이아웃 업데이트
    private func updateCollectionViewLayout() {
        if let layout = calendarView.collectionViewLayout as? UICollectionViewFlowLayout {
               let width = calendarView.frame.width / 7
               let height = width // 정사각형 셀로 가정 (1:1 비율)
               layout.itemSize = CGSize(width: width, height: height)
               
               // 헤더 사이즈도 업데이트
               layout.headerReferenceSize = CGSize(width: calendarView.frame.width, height: 30)
               
               calendarView.collectionViewLayout.invalidateLayout()
           }
    }
    
    /// 특정 날짜의 이벤트 업데이트 및 알림
    private func updateEventTable(for date: Date) {
        selectedDate = date
        selectedDateEvents = getEventsForDate(date)
        onDateSelected?(date, selectedDateEvents)
    }
    
    /// 요일 이름 배열 가져오기
    private func getWeekdaySymbols() -> [String] {
        return ["일", "월", "화", "수", "목", "금", "토"]
    }
    
    /// 해당 요일이 주말인지 확인
    private func isWeekend(_ weekday: Int) -> Bool {
        return weekday == 0 || weekday == 6 // 0:일요일, 6:토요일
    }
    
    /// 요일에 맞는 색상 가져오기
    private func colorForWeekday(_ weekday: Int) -> UIColor {
        switch weekday {
        case 0: return .systemRed      // 일요일
        case 6: return .systemBlue     // 토요일
        default: return .label         // 평일
        }
    }
}

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 아이탬 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as? CalendarDayCell else {
            return UICollectionViewCell()
        }
        
        let date = days[indexPath.item]
        let isCurrentMonth = isDateInCurrentMonth(date: date, currentMonth: currentDate)
        let isToday = isToday(date: date)
        
        // 이 날짜의 이벤트 가져오기
        let events = eventsByDate.filter { isSameDay(date1: $0.key, date2: date) }.flatMap { $0.value }
        
        // 요일 계산 (0: 일요일, 6: 토요일)
        let weekday = calendar.component(.weekday, from: date) - 1
        
        // 선택된 날짜인지 확인
        let isSelected = selectedDate != nil && isSameDay(date1: date, date2: selectedDate!)
        
        cell.configure(date: date, isCurrentMonth: isCurrentMonth, isToday: isToday, events: events, weekday: weekday, isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CalendarHeaderView",
                for: indexPath
            ) as? CalendarHeaderView else {
                return UICollectionReusableView()
            }
            
            // 헤더 뷰 구성
            let weekdaySymbols = getWeekdaySymbols()
            let weekdayColors = weekdaySymbols.enumerated().map { (index, _) in colorForWeekday(index) }
            
            headerView.configure(with: weekdaySymbols, colors: weekdayColors)
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    // 클릭 리스너
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = days[indexPath.item]
        
        // 현재 달에 있는 날짜만 선택 가능
        if isDateInCurrentMonth(date: date, currentMonth: currentDate) {
            selectedDate = date
            updateEventTable(for: date)
            collectionView.reloadData()
        }
    }
    
    // 아이템 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        let height = (collectionView.frame.height - 30) / 6 // 헤더 높이 고려
        return CGSize(width: width, height: height)
    }
}
