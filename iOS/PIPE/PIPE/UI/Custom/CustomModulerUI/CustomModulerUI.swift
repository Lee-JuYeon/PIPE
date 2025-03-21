//
//  CustomModulerUI.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/09/18.
//

import Foundation
import UIKit

protocol CustomModulerUIDelegate : AnyObject{
    func didTapCell(model: AnyHashable, atIndex index: Int)

}

class CustomModulerUI<MODEL : Hashable, CELL : UITableViewCell> : UIView, UITableViewDelegate{
    
    private weak var customDelegate : CustomModulerUIDelegate?
    
    private lazy var listView : UITableView = {
        let view = UITableView()
        view.delegate = self
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.allowsSelection = true
        view.isUserInteractionEnabled = true
        view.register(CELL.self, forCellReuseIdentifier:  String(describing: CELL.self))
//        view.register(GoogleAdmobCell.self, forCellReuseIdentifier:  String(describing: GoogleAdmobCell.self))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private var cellBinding: ((CELL, MODEL, Int) -> Void)?
    func setCellBinding(_ bindingClosure: @escaping (CELL, MODEL, Int) -> Void) {
        self.cellBinding = bindingClosure
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let currentIndex = indexPath.row
        if let currentModel = dataSource.itemIdentifier(for: indexPath) {
            customDelegate?.didTapCell(
                model: AnyHashable(currentModel),
                atIndex: currentIndex
            )
        }
    }

    private var dataSource: UITableViewDiffableDataSource<Int, MODEL>!
    private func setDiffUtil(){
        dataSource = UITableViewDiffableDataSource<Int, MODEL>(tableView: listView) { tableView, indexPath, currentItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CELL.self), for: indexPath) as! CELL
            
            self.cellBinding?(cell, currentItem, indexPath.row)
            return cell
        }
    }

    
    func updateList(newList list: [MODEL]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MODEL>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
        
    private lazy var expandableButton : UILabel = {
        let view = UILabel()
        view.text = "\("filteredSearch".toLocalize()) 🔽"
        view.textColor = .textColour
        view.textAlignment = .center
        view.isUserInteractionEnabled = true // UILabel을 상호 작용 가능하게 설정
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showOptionView)))
        return view
    }()
    
    private var optionView : UIView = UIView()
    private var isOptionViewExpanded = false
    private var contentviewHeightConstraint: NSLayoutConstraint!
    @objc func showOptionView() {
        if isOptionViewExpanded {
            contentviewHeightConstraint.constant = 0
            expandableButton.text = "\("filteredSearch".toLocalize()) 🔼"
        } else {
//            if let intrinsicSize = yourView.intrinsicContentSize { 동적으로 설정된 뷰의 사이즈 가져오는법 (1)
//                let viewWidth = intrinsicSize.width
//                let viewHeight = intrinsicSize.height
//            }
//            // Auto Layout에 의해 뷰의 크기를 즉시 계산 // 동적으로 설정도ㅚㄴ 뷰의 사이즈를 가져오는 법 (2)
//            view.layoutIfNeeded()
//
//            // Auto Layout으로 설정된 뷰의 크기를 가져옴
//            let viewWidth = yourView.frame.size.width
//            let viewHeight = yourView.frame.size.height
            let intrinsicSize = self.optionView.intrinsicContentSize
            contentviewHeightConstraint.constant = intrinsicSize.height
            expandableButton.text = "\("filteredSearch".toLocalize()) 🔽"
        }
        isOptionViewExpanded = !isOptionViewExpanded
        UIView.animate(withDuration: 0.3) {
            self.optionView.layoutIfNeeded()
//            self.layoutIfNeeded()
        }
    }

    private func setUI(){
        
        self.addSubview(expandableButton)
        self.addSubview(optionView)
        self.addSubview(listView)
        
        if contentView != nil {
            self.addSubview(contentView!)
        }

        NSLayoutConstraint.activate([
            optionView.topAnchor.constraint(equalTo: self.topAnchor),
            optionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            expandableButton.topAnchor.constraint(equalTo: optionView.bottomAnchor),
            expandableButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            expandableButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            listView.topAnchor.constraint(equalTo: contentView?.bottomAnchor ?? expandableButton.bottomAnchor),
            listView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        if let contentView = contentView {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: expandableButton.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                contentView.heightAnchor.constraint(equalTo: self.heightAnchor,  multiplier: 0.5),

            ])
        }
        
        contentviewHeightConstraint = optionView.heightAnchor.constraint(equalToConstant: 0)
        contentviewHeightConstraint.isActive = true
    }
    
    // optionView, contentView, list를 받아서 초기화하는 생성자입니다.
    private var contentView: UIView?

    init(
        optionView: UIView,
        contentView: UIView?,
        delegate : CustomModulerUIDelegate
    ) {
        self.optionView = optionView
        self.contentView = contentView
        self.customDelegate = delegate
        super.init(frame: .zero)
        
        setUI()
        setDiffUtil()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
