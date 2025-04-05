//
//  CalendarDayCell.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit
import UIKit

class CalendarDayCell: UICollectionViewCell {
    static let identifier = "CalendarDayCell"
    
    // MARK: - 속성
    private var date: Date?
    private var events: [CalendarEvent] = []
    private var isCurrentMonth: Bool = true
    private var isToday: Bool = false
    private var isSelect: Bool = false
    private var weekday: Int = 0
    
    // MARK: - UI 컴포넌트
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 구성
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        // 헤더 뷰 (날짜)
        contentView.addSubview(headerView)
        headerView.addSubview(dayLabel)
        
        // 이벤트 테이블 뷰
        contentView.addSubview(eventsTableView)
        
        NSLayoutConstraint.activate([
            // 헤더 뷰
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 25),
            
            // 날짜 레이블
            dayLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            // 이벤트 테이블 뷰
            eventsTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            eventsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        eventsTableView.register(CalendarEventIndicatorCell.self, forCellReuseIdentifier: CalendarEventIndicatorCell.identifier)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.rowHeight = 14
    }
    
    // MARK: - 데이터 설정
    func configure(with date: Date, events: [CalendarEvent], isCurrentMonth: Bool, isToday: Bool, isSelected: Bool = false, weekday: Int = 0) {
        self.date = date
        self.events = events
        self.isCurrentMonth = isCurrentMonth
        self.isToday = isToday
        self.isSelect = isSelected
        self.weekday = weekday
        
        // 날짜 표시
        let day = Calendar.current.component(.day, from: date)
        dayLabel.text = "\(day)"
        
        // 날짜 색상 및 스타일 설정
        updateDayLabelAppearance()
        
        // 셀 배경색 설정
        updateCellBackground()
        
        // 테이블 뷰 갱신
        eventsTableView.reloadData()
    }
    
    private func updateDayLabelAppearance() {
        if !isCurrentMonth {
            dayLabel.textColor = .tertiaryLabel
            return
        }
        
        if isToday {
            dayLabel.font = UIFont.boldSystemFont(ofSize: 15)
            dayLabel.textColor = .systemBlue
            return
        }
        
        // 요일별 색상 설정
        switch weekday {
        case 0: // 일요일
            dayLabel.textColor = .systemRed
        case 6: // 토요일
            dayLabel.textColor = .systemBlue
        default:
            dayLabel.textColor = .label
        }
        
        dayLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    private func updateCellBackground() {
        if isSelect {
            contentView.backgroundColor = .systemGray6
            contentView.layer.borderColor = UIColor.systemBlue.cgColor
            contentView.layer.borderWidth = 1
        } else if isToday {
            contentView.backgroundColor = .systemGray6
            contentView.layer.borderColor = UIColor.systemGray4.cgColor
            contentView.layer.borderWidth = 0.5
        } else {
            contentView.backgroundColor = .systemBackground
            contentView.layer.borderColor = UIColor.systemGray5.cgColor
            contentView.layer.borderWidth = 0.5
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        events = []
        isCurrentMonth = true
        isToday = false
        isSelect = false
        weekday = 0
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CalendarDayCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 최대 3개까지만 표시 (공간 제약)
        return min(events.count, 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarEventIndicatorCell.identifier, for: indexPath) as? CalendarEventIndicatorCell else {
            return UITableViewCell()
        }
        
        let event = events[indexPath.row]
        cell.configure(with: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 14 // 이벤트 인디케이터 높이 고정
    }
}

// MARK: - 이벤트 인디케이터 셀
class CalendarEventIndicatorCell: UITableViewCell {
    static let identifier = "CalendarEventIndicatorCell"
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(indicatorView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 6),
            indicatorView.heightAnchor.constraint(equalToConstant: 6),
            
            titleLabel.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with event: CalendarEvent) {
        titleLabel.text = event.title
        
        // 이벤트 색상 설정
        let colorIndex = Int(event.colorIndex)
        indicatorView.backgroundColor = getColorForEvent(colorIndex: colorIndex)
    }
    
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
