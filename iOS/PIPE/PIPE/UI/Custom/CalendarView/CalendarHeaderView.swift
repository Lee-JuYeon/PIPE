//
//  CalendarDayTitleCell.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit

// MARK: - CalendarHeaderView
class CalendarHeaderView: UICollectionReusableView {
    
    private let weekdayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(weekdayStackView)
        
        NSLayoutConstraint.activate([
            weekdayStackView.topAnchor.constraint(equalTo: topAnchor),
            weekdayStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            weekdayStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            weekdayStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    /// 요일 표시 구성 - 메소드 기반 접근
    func configure(with weekdaySymbols: [String], colors: [UIColor]) {
        // 기존 요소 제거
        weekdayStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 요일 레이블 추가
        for (index, symbol) in weekdaySymbols.enumerated() {
            let label = UILabel()
            label.text = symbol
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 13)
            
            // 색상 설정
            label.textColor = index < colors.count ? colors[index] : .label
            
            weekdayStackView.addArrangedSubview(label)
        }
    }
}
