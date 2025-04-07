//
//  CalendarUtils.swift
//  PIPE
//
//  Created by Jupond on 4/3/25.
//

import Foundation
import UIKit

class ScheduleListView : UIView {
    
    private var events: [CalendarModel] = []
    var onEventSelected: ((CalendarModel) -> Void)?
    var onAddButtonTapped: (() -> Void)?
    
    private let scheduelListView: UICollectionView = {
        // 수평 스크롤을 위한 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 80)
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: 120, height: 80) // 헤더 크기 설정
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(ScheduleEventCell.self, forCellWithReuseIdentifier: ScheduleEventCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupCollectionView()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(scheduelListView)
        
        NSLayoutConstraint.activate([
            scheduelListView.topAnchor.constraint(equalTo: topAnchor),
            scheduelListView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scheduelListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scheduelListView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
        
    /// 이벤트 목록 업데이트
    func updateEvents(_ events: [CalendarModel]) {
        self.events = events
        scheduelListView.reloadData()
    }
    
    private func setupCollectionView() {
        // 이벤트 셀 등록
        scheduelListView.register(
            ScheduleEventCell.self,
            forCellWithReuseIdentifier: ScheduleEventCell.identifier
        )
        
        // 헤더 등록
        scheduelListView.register(
            ScheduleHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ScheduleHeaderCell.identifier
        )
        
        scheduelListView.delegate = self
        scheduelListView.dataSource = self
    }
}

extension ScheduleListView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ScheduleEventCell.identifier,
            for: indexPath
        ) as? ScheduleEventCell else {
            return UICollectionViewCell()
        }
        
        let event = events[indexPath.item]
        cell.configure(with: event)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ScheduleHeaderCell.identifier,
                for: indexPath
            ) as? ScheduleHeaderCell else {
                return UICollectionReusableView()
            }
            
            // 헤더의 버튼에 액션 추가
            headerView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    @objc private func addButtonTapped() {
        onAddButtonTapped?()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = events[indexPath.item]
        onEventSelected?(event)
    }
}
