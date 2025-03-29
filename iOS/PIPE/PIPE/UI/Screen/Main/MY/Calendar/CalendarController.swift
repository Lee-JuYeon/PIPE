//
//  CalendarController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import UIKit

class CalendarController: UIViewController {
    
    // MARK: - Properties
    
    // 현재 표시하는 달
    private var currentDate = Date()
    
    // 달력 데이터
    private var days: [Date] = []
    private var eventsByDate: [Date: [CalendarEvent]] = [:]
    
    // 선택한 날짜
    private var selectedDate: Date?
    
    // 이벤트 관리자
    private let eventManager = CalendarEventManager.shared
    
    // 요일 표시 (영어)
    private let weekdaySymbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
   
    // MARK: - UI Components
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("◀", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let todayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("오늘", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     private let weekdayStackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.alignment = .center
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
         
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = .zero // 헤더를 사용하지 않음 (스택뷰로 대체)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false // 스크롤 비활성화
        cv.register(CalendarDayCell.self, forCellWithReuseIdentifier: CalendarDayCell.identifier)
        return cv
    }()
    
    private let eventTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.layer.cornerRadius = 8
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.layer.shadowRadius = 4
        tableView.layer.shadowOpacity = 0.1
        return tableView
    }()
    
    private let addEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+ 일정 추가", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 선택된 날짜의 이벤트 목록
    private var selectedDateEvents: [CalendarEvent] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWeekdayHeader()
        setupCollectionView()
        setupTableView()
        setupActions()
        setupNotifications()
        reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 레이아웃이 결정된 후 셀 크기 조정
        updateCollectionViewLayout()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = "달력"
        view.backgroundColor = .systemBackground
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerView)
        headerView.addSubview(monthLabel)
        headerView.addSubview(previousButton)
        headerView.addSubview(nextButton)
        headerView.addSubview(todayButton)
        view.addSubview(weekdayStackView)
        view.addSubview(collectionView)
        view.addSubview(eventTableView)
        view.addSubview(addEventButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            monthLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            monthLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            previousButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            previousButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            
            nextButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            todayButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            todayButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -20),
            
            weekdayStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            weekdayStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekdayStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekdayStackView.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: weekdayStackView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            // 화면에 맞게 컬렉션 뷰 높이 설정 - 6주 표시를 위해 고정 높이 사용
//            collectionView.heightAnchor.constraint(equalToConstant: 330), // 6주 x 55 높이

            eventTableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            eventTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            eventTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            eventTableView.bottomAnchor.constraint(equalTo: addEventButton.topAnchor, constant: -10),
            
            addEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addEventButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addEventButton.widthAnchor.constraint(equalToConstant: 120),
            addEventButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupWeekdayHeader() {
        // 기존 요소 제거
        weekdayStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 요일 레이블 추가
        for (index, symbol) in weekdaySymbols.enumerated() {
            let label = UILabel()
            label.text = symbol
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 13)
            
            // 일요일과 토요일 색상 설정
            if index == 0 {  // 일요일
                label.textColor = .systemRed
            } else if index == 6 { // 토요일
                label.textColor = .systemBlue
            } else {
                label.textColor = .label
            }
            
            weekdayStackView.addArrangedSubview(label)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
//        // 컬렉션 뷰 레이아웃 설정
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.minimumInteritemSpacing = 0
//            layout.minimumLineSpacing = 0
//            layout.headerReferenceSize = CGSize(width: view.frame.width, height: 30)
//        }
    }
    
    private func updateCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.frame.width / 7
            let height = min(width, collectionView.frame.height / 6) // 셀 높이가 너무 크지 않도록 제한
            layout.itemSize = CGSize(width: width, height: height)
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func setupTableView() {
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventCell")
        eventTableView.tableFooterView = UIView()
    }
    
    private func setupActions() {
        previousButton.addTarget(self, action: #selector(goToPreviousMonth), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(goToNextMonth), for: .touchUpInside)
        todayButton.addTarget(self, action: #selector(goToToday), for: .touchUpInside)
        addEventButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEventsUpdated(_:)),
            name: CalendarEventManager.eventsUpdatedNotification,
            object: nil
        )
    }
        
    private func reloadData() {
        // 월 제목 업데이트
        monthLabel.text = CalendarUtils.shared.monthName(date: currentDate)
        
        // 날짜 및 이벤트 데이터 로드
        days = CalendarUtils.shared.daysInMonth(date: currentDate)
        eventsByDate = eventManager.getEventsForMonth(date: currentDate)
        
        collectionView.reloadData()
        
        // 선택된 날짜가 있으면 이벤트 테이블 업데이트
        if let selectedDate = selectedDate {
            updateEventTable(for: selectedDate)
        }
    }
    
    private func updateEventTable(for date: Date) {
        selectedDate = date
        selectedDateEvents = eventManager.getEvents(for: date)
        
        if selectedDateEvents.isEmpty {
            eventTableView.isHidden = true
        } else {
            eventTableView.isHidden = false
            eventTableView.reloadData()
        }
    }
    
    @objc private func handleEventsUpdated(_ notification: Notification) {
        // 이벤트 업데이트 시 달력 새로고침
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.eventsByDate = self.eventManager.getEventsForMonth(date: self.currentDate)
            self.collectionView.reloadData()
            
            // 선택된 날짜가 있으면 이벤트 테이블 업데이트
            if let selectedDate = self.selectedDate {
                self.updateEventTable(for: selectedDate)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func goToPreviousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
            reloadData()
        }
    }
    
    @objc private func goToNextMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
            currentDate = newDate
            reloadData()
        }
    }
    
    @objc private func goToToday() {
        currentDate = Date()
        selectedDate = currentDate
        reloadData()
        
        // 오늘 날짜가 있는 셀로 스크롤
        for (index, date) in days.enumerated() {
            if Calendar.current.isDateInToday(date) {
                let indexPath = IndexPath(item: index, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                break
            }
        }
    }
    
    @objc private func addEvent() {
        // 현재 선택된 날짜가 없으면 현재 날짜로 설정
        let eventDate = selectedDate ?? currentDate
        showAddEventAlert(for: eventDate)
    }
    
    private func showAddEventAlert(for date: Date) {
            let alert = UIAlertController(title: "일정 추가", message: nil, preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.placeholder = "일정 제목"
            }
            
            alert.addTextField { textField in
                textField.placeholder = "메모 (선택사항)"
            }
            
            // 날짜 선택용 DatePicker 생성
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            datePicker.date = date
            
            // DatePicker를 포함할 컨테이너 생성
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(datePicker)
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                datePicker.topAnchor.constraint(equalTo: containerView.topAnchor),
                datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            
            // DatePicker를 알림에 추가
            alert.view.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            // 알림 뷰 크기 설정을 위한 제약 조건
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 80),
                containerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
                containerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
                containerView.heightAnchor.constraint(equalToConstant: 200)
            ])
            
            // 알림 뷰 크기 조정
            let height: NSLayoutConstraint = NSLayoutConstraint(
                item: alert.view!, attribute: .height, relatedBy: .equal,
                toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 360
            )
            alert.view.addConstraint(height)
            
            // 색상 선택 세그먼트 추가
            let colorSegment = UISegmentedControl(items: ["파랑", "빨강", "초록", "주황", "보라"])
            colorSegment.selectedSegmentIndex = 0
            colorSegment.translatesAutoresizingMaskIntoConstraints = false
            
            alert.view.addSubview(colorSegment)
            NSLayoutConstraint.activate([
                colorSegment.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
                colorSegment.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
                colorSegment.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20)
            ])
            
            let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
                guard let self = self,
                      let titleField = alert.textFields?[0],
                      let title = titleField.text,
                      !title.isEmpty else { return }
                
                let notes = alert.textFields?[1].text
                let date = datePicker.date
                let colorIndex = colorSegment.selectedSegmentIndex
                
                if self.eventManager.addEvent(title: title, date: date, notes: notes, color: colorIndex) {
                    // 저장한 날짜를 선택된 날짜로 설정
                    self.selectedDate = date
                    self.updateEventTable(for: date)
                } else {
                    self.showAlert(title: "저장 실패", message: "일정을 저장하지 못했습니다.")
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        }
    
    private func editEvent(_ event: CalendarEvent) {
        let alert = UIAlertController(title: "일정 수정", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "일정 제목"
            textField.text = event.title
        }
        
        alert.addTextField { textField in
            textField.placeholder = "메모 (선택사항)"
            textField.text = event.notes
        }
        
        // 날짜 선택용 DatePicker 생성
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.date = event.date
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 80),
            containerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let height: NSLayoutConstraint = NSLayoutConstraint(
            item: alert.view!, attribute: .height, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 360
        )
        alert.view.addConstraint(height)
        
        // 색상 선택 세그먼트 추가
        let colorSegment = UISegmentedControl(items: ["파랑", "빨강", "초록", "주황", "보라"])
        colorSegment.selectedSegmentIndex = event.color
        colorSegment.translatesAutoresizingMaskIntoConstraints = false
        
        alert.view.addSubview(colorSegment)
        NSLayoutConstraint.activate([
            colorSegment.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            colorSegment.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            colorSegment.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20)
        ])
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let self = self,
                  let titleField = alert.textFields?[0],
                  let title = titleField.text,
                  !title.isEmpty else { return }
            
            let notes = alert.textFields?[1].text
            let date = datePicker.date
            let colorIndex = colorSegment.selectedSegmentIndex
            
            if self.eventManager.updateEvent(id: event.id, title: title, date: date, notes: notes, color: colorIndex) {
                // 수정된 날짜를 선택된 날짜로 설정
                self.selectedDate = date
                self.updateEventTable(for: date)
            } else {
                self.showAlert(title: "수정 실패", message: "일정을 수정하지 못했습니다.")
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func deleteEvent(_ event: CalendarEvent) {
        let alert = UIAlertController(title: "일정 삭제", message: "이 일정을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            if self.eventManager.deleteEvent(id: event.id) {
                // 삭제 성공 시 테이블 업데이트
                if let selectedDate = self.selectedDate {
                    self.updateEventTable(for: selectedDate)
                }
            } else {
                self.showAlert(title: "삭제 실패", message: "일정을 삭제하지 못했습니다.")
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showEventDetails(for event: CalendarEvent) {
        let alert = UIAlertController(title: event.title, message: nil, preferredStyle: .actionSheet)
        
        // 날짜 포맷팅
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: event.date)
        alert.message = "날짜: \(dateString)\n메모: \(event.notes ?? "없음")"
        
        alert.addAction(UIAlertAction(title: "편집", style: .default) { [weak self] _ in
            self?.editEvent(event)
        })
        
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.deleteEvent(event)
        })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        // iPad 지원
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension CalendarController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as? CalendarDayCell else {
            return UICollectionViewCell()
        }
        
        let date = days[indexPath.item]
        let isCurrentMonth = CalendarUtils.shared.isDateInCurrentMonth(date: date, currentMonth: currentDate)
        let isToday = CalendarUtils.shared.isToday(date: date)
        
        // 이 날짜의 이벤트 가져오기
        let events = eventsByDate.filter { CalendarEvent.isSameDay(date1: $0.key, date2: date) }.flatMap { $0.value }
        
        // 요일 계산 (0: 일요일, 6: 토요일)
        let weekday = Calendar.current.component(.weekday, from: date) - 1
        
        // 선택된 날짜인지 확인
        let isSelected = selectedDate != nil && CalendarEvent.isSameDay(date1: date, date2: selectedDate!)
        
        cell.configure(date: date, isCurrentMonth: isCurrentMonth, isToday: isToday, events: events, weekday: weekday, isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = days[indexPath.item]
        
        // 현재 달에 있는 날짜만 선택 가능
        if CalendarUtils.shared.isDateInCurrentMonth(date: date, currentMonth: currentDate) {
            selectedDate = date
            updateEventTable(for: date)
            collectionView.reloadData() // 선택된 날짜 강조 표시를 위해 새로고침
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarWeekdayHeaderCell.identifier, for: indexPath) as? CalendarWeekdayHeaderCell else {
                return UICollectionReusableView()
            }
            
            // 요일 표시 (일~토)
            let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
            let weekday = weekdays[indexPath.item % 7]
            let isWeekend = indexPath.item % 7 == 0 || indexPath.item % 7 == 6 // 일요일(0) 또는 토요일(6)
            
            headerView.configure(with: weekday, isWeekend: isWeekend)
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 60)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalendarController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        guard indexPath.row < selectedDateEvents.count else {
            return cell
        }
        
        let event = selectedDateEvents[indexPath.row]
        
        // 셀 구성
        cell.textLabel?.text = event.title
        
        // 이벤트 색상 표시
        let colorView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: cell.frame.height))
        colorView.backgroundColor = getColorForEvent(colorIndex: event.color)
        cell.contentView.addSubview(colorView)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            colorView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            colorView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
            colorView.widthAnchor.constraint(equalToConstant: 4)
        ])
        
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.textLabel!.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 12),
            cell.textLabel!.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.row < selectedDateEvents.count else { return }
        
        let event = selectedDateEvents[indexPath.row]
        showEventDetails(for: event)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let selectedDate = selectedDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return "\(dateFormatter.string(from: selectedDate)) 일정"
    }
    
    // 이벤트 색상 인덱스로부터 UIColor 생성
    private func getColorForEvent(colorIndex: Int) -> UIColor {
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

struct CalendarEvent: Codable, Equatable, Identifiable {
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

// 달력 관리를 위한 유틸리티 함수들
class CalendarUtils {
    static let shared = CalendarUtils()
    private let calendar = Calendar.current
    
    // 현재 달의 모든 날짜 가져오기
    func daysInMonth(date: Date) -> [Date] {
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
    
    // 날짜에서 일(day) 구하기
    func dayFromDate(_ date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    // 날짜가 현재 달에 속하는지 확인
    func isDateInCurrentMonth(date: Date, currentMonth: Date) -> Bool {
        let comp1 = calendar.dateComponents([.year, .month], from: date)
        let comp2 = calendar.dateComponents([.year, .month], from: currentMonth)
        return comp1.year == comp2.year && comp1.month == comp2.month
    }
    
    // 오늘 날짜인지 확인
    func isToday(date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }
    
    // 날짜 형식 설정
    func formatDate(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // 월 이름 가져오기
    func monthName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

class CalendarEventManager {
    static let shared = CalendarEventManager()
    
    // NotificationCenter 이름
    static let eventsUpdatedNotification = Notification.Name("CalendarEventsUpdated")
    
    // UserDefaults 키
    private let eventsKey = "calendarEvents"
    
    // 메모리 내 이벤트 캐시
    private var eventsCache: [CalendarEvent] = []
    
    private init() {
        loadEvents()
    }
    
    // 이벤트 로드
    func loadEvents() {
        if let data = UserDefaults.standard.data(forKey: eventsKey) {
            do {
                eventsCache = try JSONDecoder().decode([CalendarEvent].self, from: data)
            } catch {
                print("이벤트 로드 오류: \(error)")
                eventsCache = []
            }
        }
    }
    
    // 이벤트 저장
    private func saveEvents() -> Bool {
        do {
            let data = try JSONEncoder().encode(eventsCache)
            UserDefaults.standard.set(data, forKey: eventsKey)
            UserDefaults.standard.synchronize()
            
            // 이벤트 업데이트 알림
            NotificationCenter.default.post(
                name: CalendarEventManager.eventsUpdatedNotification,
                object: nil,
                userInfo: ["events": eventsCache]
            )
            return true
        } catch {
            print("이벤트 저장 오류: \(error)")
            return false
        }
    }
    
    // 모든 이벤트 가져오기
    func getAllEvents() -> [CalendarEvent] {
        return eventsCache
    }
    
    // 특정 날짜의 이벤트 가져오기
    func getEvents(for date: Date) -> [CalendarEvent] {
        return eventsCache.filter { CalendarEvent.isSameDay(date1: $0.date, date2: date) }
    }
    
    // 이벤트 추가
    @discardableResult
    func addEvent(title: String, date: Date, notes: String? = nil, color: Int = 0) -> Bool {
        let event = CalendarEvent(title: title, date: date, notes: notes, color: color)
        eventsCache.append(event)
        return saveEvents()
    }
    
    // 이벤트 업데이트
    @discardableResult
    func updateEvent(id: UUID, title: String, date: Date, notes: String? = nil, color: Int = 0) -> Bool {
        guard let index = eventsCache.firstIndex(where: { $0.id == id }) else {
            return false
        }
        
        let updatedEvent = CalendarEvent(id: id, title: title, date: date, notes: notes, color: color)
        eventsCache[index] = updatedEvent
        return saveEvents()
    }
    
    // 이벤트 삭제
    @discardableResult
    func deleteEvent(id: UUID) -> Bool {
        let initialCount = eventsCache.count
        eventsCache.removeAll { $0.id == id }
        
        if initialCount > eventsCache.count {
            return saveEvents()
        }
        return false
    }
    
    // 모든 이벤트 삭제
    @discardableResult
    func deleteAllEvents() -> Bool {
        eventsCache.removeAll()
        return saveEvents()
    }
    
    // 월 단위 이벤트 가져오기
    func getEventsForMonth(date: Date) -> [Date: [CalendarEvent]] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return [:]
        }
        
        var eventsByDate: [Date: [CalendarEvent]] = [:]
        
        for day in 1...range.count {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                let dayEvents = getEvents(for: date)
                if !dayEvents.isEmpty {
                    eventsByDate[date] = dayEvents
                }
            }
        }
        
        return eventsByDate
    }
}

class CalendarDayCell: UICollectionViewCell {
    static let identifier = "CalendarDayCell"
    
    // MARK: - Properties
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let eventIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 이 셀의 날짜 정보
    var date: Date?
    
    // 이벤트 표시 색상
    var eventColor: UIColor? {
        didSet {
            if let color = eventColor {
                eventIndicator.backgroundColor = color
                eventIndicator.isHidden = false
            } else {
                eventIndicator.isHidden = true
            }
        }
    }
    
    // 현재 달 여부
    var isCurrentMonth: Bool = true {
        didSet {
            updateDayLabelColor()
//            dayLabel.textColor = isCurrentMonth ? .label : .tertiaryLabel
        }
    }

    // 오늘 여부
    var isToday: Bool = false {
        didSet {
            updateDayLabelColor()
            updateBackgroundColor()
//            if isToday {
//                dayLabel.font = UIFont.boldSystemFont(ofSize: 15)
//                dayLabel.textColor = .systemRed
//            } else {
//                dayLabel.font = UIFont.systemFont(ofSize: 15)
//                dayLabel.textColor = isCurrentMonth ? .label : .tertiaryLabel
//            }
        }
    }
    
    // 요일 (0: 일요일, 6: 토요일)
    var weekday: Int = 0 {
        didSet {
            updateDayLabelColor()
            updateBackgroundColor()
        }
    }
    
    // 이벤트 수
    var eventCount: Int = 0 {
        didSet {
            eventIndicator.isHidden = eventCount == 0
        }
    }
    
    // 선택 여부
    var isDateSelected: Bool = false {
        didSet {
            updateBackgroundColor()
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(eventIndicator)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 20),
            
            eventIndicator.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            eventIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventIndicator.widthAnchor.constraint(equalToConstant: 6),
            eventIndicator.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    // MARK: - Configuration
    func configure(date: Date, isCurrentMonth: Bool, isToday: Bool, events: [CalendarEvent] = [], weekday: Int, isSelected: Bool = false) {
        self.date = date
        self.isCurrentMonth = isCurrentMonth
        self.isToday = isToday
        self.weekday = weekday
        self.isDateSelected = isSelected
        
        let day = CalendarUtils.shared.dayFromDate(date)
        dayLabel.text = "\(day)"
        
        eventCount = events.count
        
        if let firstEvent = events.first {
            let color = getColorForEvent(colorIndex: firstEvent.color)
            eventColor = color
        } else {
            eventColor = nil
        }
        
        updateDayLabelColor()
        updateBackgroundColor()
    }
    
    private func updateDayLabelColor() {
        if !isCurrentMonth {
            // 현재 달이 아닌 경우 회색 처리
            dayLabel.textColor = .tertiaryLabel
            return
        }
        
        if isToday {
            // 오늘인 경우 굵은 글씨로 처리
//            dayLabel.font = UIFont.boldSystemFont(ofSize: 15)
//            dayLabel.textColor = .systemRed
            dayLabel.font = UIFont.boldSystemFont(ofSize: 18)
            dayLabel.textColor = .black
            return
        }
        
        // 주말 색상 처리
        switch weekday {
        case 0: // 일요일
            dayLabel.textColor = .systemRed
        case 6: // 토요일
            dayLabel.textColor = .systemBlue
        default: // 평일
            dayLabel.textColor = .label
        }
        
        // 기본 폰트 설정
        dayLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    private func updateBackgroundColor() {
        if isDateSelected {
            // 선택된 날짜는 연한 회색 배경
            contentView.backgroundColor = .systemGray6
            return
        }
        
        if isToday {
            // 오늘은 연한 회색 배경
            contentView.backgroundColor = .systemGray6
            return
        }
        
        contentView.backgroundColor = .systemBackground
//        // 주말 배경색 처리
//        switch weekday {
//        case 0: // 일요일
//            contentView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
//        case 6: // 토요일
//            contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
//        default: // 평일
//            contentView.backgroundColor = .systemBackground
//        }
    }
    
    // 이벤트 색상 인덱스로부터 UIColor 생성
    private func getColorForEvent(colorIndex: Int) -> UIColor {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        dayLabel.textColor = .label
        dayLabel.font = UIFont.systemFont(ofSize: 15)
        eventIndicator.isHidden = true
        isToday = false
        isCurrentMonth = true
        date = nil
        contentView.backgroundColor = .systemBackground
    }
}

// 요일 헤더 셀
class CalendarWeekdayHeaderCell: UICollectionReusableView {
    static let identifier = "CalendarWeekdayHeaderCell"
    
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(weekdayLabel)
        
        NSLayoutConstraint.activate([
            weekdayLabel.topAnchor.constraint(equalTo: topAnchor),
            weekdayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            weekdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            weekdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with weekday: String, isWeekend: Bool = false) {
        weekdayLabel.text = weekday
        if weekday == "Sun" {
            weekdayLabel.textColor = .systemRed
        } else if weekday == "Sat" {
            weekdayLabel.textColor = .systemBlue
        } else {
            weekdayLabel.textColor = .label
        }
    }
}
