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
    private var eventsByDate: [Date: [CalendarModel]] = [:]
    
    // ViewModel
    private var viewModel: CalendarViewModel?
    
    // 날짜 선택 콜백
    var onDateSelected: ((Date, [CalendarModel]) -> Void)?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupViewModel()
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
    
    // ViewModel 설정
    func setViewModel(_ viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        setupViewModel()
    }
    
    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        
        // ViewModel의 이벤트 업데이트 감지
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventsUpdated(_:)),
            name: Notification.Name("CalendarEventsUpdated"),
            object: nil
        )
        
        // 초기 데이터 로드
        viewModel.fetchEventsForMonth(currentDate)
    }
    
    @objc private func handleEventsUpdated(_ notification: Notification) {
        if let events = notification.userInfo?["events"] as? [CalendarModel] {
            updateCalendarWithEvents(events)
        }
    }
    
    private func updateCalendarWithEvents(_ events: [CalendarModel]) {
        // 이벤트를 날짜별로 그룹화
        eventsByDate = groupEventsByDate(events)
        
        // 컬렉션 뷰 리로드
        DispatchQueue.main.async {
            self.calendarView.reloadData()
        }
    }
    private func groupEventsByDate(_ events: [CalendarModel]) -> [Date: [CalendarModel]] {
        var eventsByDate: [Date: [CalendarModel]] = [:]
        
        for event in events {
            // startDate는 non-optional이므로 바로 사용
            let eventDate = event.startDate
            
            // 날짜 시간 부분 제거 (일자만 비교)
            let dayStart = calendar.startOfDay(for: eventDate)
            
            // 해당 날짜에 이벤트 추가
            if var dateEvents = eventsByDate[dayStart] {
                dateEvents.append(event)
                eventsByDate[dayStart] = dateEvents
            } else {
                eventsByDate[dayStart] = [event]
            }
        }
        
        return eventsByDate
    }
    // MARK: - 공개 메서드
    
    /// 날짜 설정 및 달력 리로드
    func setDate(_ date: Date) {
        currentDate = date
        reloadCalendar()
        
        // ViewModel에 선택한 월 업데이트
        viewModel?.fetchEventsForMonth(date)
    }
    
    /// 현재 표시 중인 날짜 반환
    func getCurrentDate() -> Date {
        return currentDate
    }
    
    /// 현재 선택된 날짜 반환
    func getSelectedDate() -> Date? {
        return selectedDate
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
    func getEventsForDate(_ date: Date) -> [CalendarModel] {
        let dayStart = calendar.startOfDay(for: date)
        return eventsByDate[dayStart] ?? []
    }
    
    /// 현재 월의 모든 날짜 가져오기
    func getDaysInCurrentMonth() -> [Date] {
        return days
    }
    
    /// 달력 새로고침
    func reloadCalendar() {
        // 날짜 데이터 가져오기
        days = daysInMonth(date: currentDate)
        
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
        let selectedEvents = getEventsForDate(date)
        
        // ViewModel에 선택된 날짜 업데이트
        viewModel?.setSelectedDate(date)
        
        // 콜백 호출
        onDateSelected?(date, selectedEvents)
    }
    
    /// 요일 이름 배열 가져오기
    private func getWeekdaySymbols() -> [String] {
        return ["일", "월", "화", "수", "목", "금", "토"]
    }
    
    /// 요일에 맞는 색상 가져오기
    private func colorForWeekday(_ weekday: Int) -> UIColor {
        switch weekday {
        case 0: return .systemRed      // 일요일
        case 6: return .systemBlue     // 토요일
        default: return .label         // 평일
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 아이템 갯수
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
        let events = getEventsForDate(date)
        
        // 요일 계산 (0: 일요일, 6: 토요일)
        let weekday = calendar.component(.weekday, from: date) - 1
        
        // 선택된 날짜인지 확인
        let isSelected = selectedDate != nil && isSameDay(date1: date, date2: selectedDate!)
        
        cell.configure(with: date, events: events, isCurrentMonth: isCurrentMonth, isToday: isToday, isSelected: isSelected, weekday: weekday)
        
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
    
    // 아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        let height = (collectionView.frame.height - 30) / 6 // 헤더 높이 고려
        return CGSize(width: width, height: height)
    }
}
