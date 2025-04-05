//
//  CalendarEventModel.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit

class CalendarWIgetListView : UIView {
    
    private var viewModel: CalendarViewModel!
    
    // 현재 날짜 텍스트
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 이전 달력 버튼
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("◀", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 다음 달력 버튼
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 오늘 버튼
    private let todayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("오늘", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func configure(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        self.addSubview(monthLabel)
        self.addSubview(previousButton)
        self.addSubview(nextButton)
        self.addSubview(todayButton)
        
        NSLayoutConstraint.activate([
            monthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            monthLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            previousButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            previousButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            todayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            todayButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -20),
        ])
    }
    
}
