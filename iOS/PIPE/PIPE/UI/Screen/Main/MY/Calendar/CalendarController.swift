//
//  CalendarController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import UIKit

class CalendarController: UIViewController, CalendarViewModelDelegate {
   
    private var viewModel: CalendarViewModel!
   
    // 현재 표시하는 달
    private var currentDate = Date()
    
    private let calendarWidgetListView : CalendarWIgetListView = {
        let view = CalendarWIgetListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        // ViewModel 설정
        setupViewModel()
        
        // 초기 데이터 로드
        loadInitialData()
        
        // 첫 로드 시 현재 날짜 설정
        calendarView.setDate(currentDate)
        
        // 날짜 선택 콜백 설정
        calendarView.onDateSelected = { [weak self] date, events in
            self?.handleDateSelected(date, events: events)
        }
                
        // 일정 선택 콜백 설정
        scheduleListView.onEventSelected = { [weak self] eventID in
           
        }
        
        // 일정 추가 버튼 콜백 설정
        scheduleListView.onAddButtonTapped = { [weak self] in
            
        }
    }
    
    private func setupViewModel() {
        // Repository 생성
        let repository = CalendarRepository()
        
        // ViewModel 생성 및 Delegate 설정
        viewModel = CalendarViewModel(repository: repository)
        viewModel.delegate = self
        
        calendarView.setViewModel(viewModel)
        calendarWidgetListView.configure(viewModel: viewModel)
    }
    
    private func loadInitialData() {
        // 현재 달의 이벤트 로드
        viewModel.fetchEventsForMonth(Date())
        
        // 오늘 날짜 선택
        calendarView.setSelectedDate(Date())
    }
        
       
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(calendarWidgetListView)
        view.addSubview(calendarView)
        view.addSubview(scheduleListView)
        
        NSLayoutConstraint.activate([
            // 달력 위젯 뷰
            calendarWidgetListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            calendarWidgetListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarWidgetListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // 달력 뷰
            calendarView.topAnchor.constraint(equalTo: calendarWidgetListView.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // 일정 리스트 뷰
            scheduleListView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            scheduleListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scheduleListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scheduleListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
    
  
    private func handleDateSelected(_ date: Date, events: [CalendarModel]) {
       // ScheduleListView 업데이트
       scheduleListView.updateEvents(events)
       
       // 상태 정보 업데이트 (필요한 경우 날짜 표시 등)
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy년 MM월 dd일"
       title = dateFormatter.string(from: date)
    }
  
    
    // Action methods
    @objc private func goToPreviousMonth() {
        viewModel.goToPreviousMonth()
    }

    @objc private func goToNextMonth() {
        viewModel.goToNextMonth()
    }

    @objc private func goToToday() {
        viewModel.goToToday()
    }

    // CalendarViewModelDelegate 메서드 구현에 추가
    func didChangeMonth(date: Date) {
        // 월 레이블 업데이트
//        monthYearLabel.text = viewModel.getFormattedMonthString()
        
        // 달력 뷰 업데이트
        calendarView.setDate(date)
    }
   
    func didUpdateEvents(events: [CalendarModel]) {
    // asdf
    }
    
    func didCompleteEventOperation(success: Bool, operationType: CalendarViewModel.OperationType) {
        // asdf
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
