//
//  CalendarController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import UIKit

class CalendarController: UIViewController {
    
    // 현재 표시하는 달
    private var currentDate = Date()
    
    // CalendarView 인스턴스 추가
    private let calendarView: CalendarView = {
        let view = CalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    private let scheduleListView : ScheduleListView = {
        let view = ScheduleListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 첫 로드 시 현재 날짜 설정
        calendarView.setDate(currentDate)
        
        // 날짜 선택 콜백 설정
        calendarView.onDateSelected = { [weak self] date, events in
            
        }
        
        scheduleListView.onEventSelected = { [weak self] event in
            
        }
        scheduleListView.onAddButtonTapped = { [weak self] in
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
//        view.addSubview(headerView)
//        headerView.addSubview(monthLabel)
//        headerView.addSubview(previousButton)
//        headerView.addSubview(nextButton)
//        headerView.addSubview(addScheduleButton)
//        headerView.addSubview(todayButton)
        view.addSubview(calendarView)
        view.addSubview(scheduleListView)
        
        NSLayoutConstraint.activate([
            // 헤더 뷰 제약조건
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            headerView.heightAnchor.constraint(equalToConstant: 50),
//            
//            // 월 표시 라벨
//            monthLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
//            monthLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            
//            // 이전 버튼
//            previousButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            previousButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
//            
//            // 다음 버튼
//            nextButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            nextButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
//            
//            // 오늘 버튼
//            todayButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            todayButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -20),
//            
//            // 일정 추가 버튼
//            addScheduleButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 10),
//            addScheduleButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 달력 뷰
//            calendarView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // 일정 리스트 뷰
            scheduleListView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            scheduleListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scheduleListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scheduleListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
        
        // 초기 월 표시 업데이트
        updateMonthLabel()
    }
    
  
  
    
    // 현재 월 표시 업데이트
    private func updateMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
//        monthLabel.text = formatter.string(from: currentDate)
    }
    
    
//    @objc private func goToPreviousMonth() {
//        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
//            currentDate = newDate
//            calendarView.setDate(currentDate)
//            updateMonthLabel()
//        }
//    }
//    
//    @objc private func goToNextMonth() {
//        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
//            currentDate = newDate
//            calendarView.setDate(currentDate)
//            updateMonthLabel()
//        }
//    }
//    
//    @objc private func goToToday() {
//        currentDate = Date()
//        calendarView.setDate(currentDate)
//        calendarView.setSelectedDate(currentDate)
//        updateMonthLabel()
//    }
    
   
    
}
