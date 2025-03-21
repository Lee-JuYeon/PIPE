//
//  DropDownTextField.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/22.
//

import Foundation
import UIKit

class DropDownTextField: UIView, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    
    private var textField : UITextField!
    private func setTextField() {
        textField = UITextField()
        textField.delegate = self
        textField.placeholder = "aaa1123"
        textField.borderStyle = .none
        textField.keyboardType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    private func anchorTextField(){
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }

    var dropdownList: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var tableView : UITableView!
    private func setTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .lightGray
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.register(DropDownCell.self, forCellReuseIdentifier: "DropDownCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func anchorTableView(){
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height) // 동적으로 조정
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
        setTableView()
        anchorTextField()
        anchorTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTextField()
        setTableView()
        anchorTextField()
        anchorTableView()
    }

    

    // UITextFieldDelegate 메서드 구현
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = dropdownList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = dropdownList[indexPath.row]
        textField.text = selectedOption
    }
}


//class DropDownTextField: UIView {
//    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    private let cornerRadius: CGFloat = 8.0
//    private let borderWidth: CGFloat = 1.0
//    private let borderColor: UIColor = .gray
//    private let cellHeight: CGFloat = 40.0
//    
//    private let textField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .none
//        textField.backgroundColor = .clear
//        textField.keyboardType = .default
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.separatorStyle = .none
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    var options: [String] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    var text: String? {
//        get { return textField.text }
//        set { textField.text = newValue }
//    }
//    
//    var delegate: UITextFieldDelegate? {
//        get { return textField.delegate }
//        set { textField.delegate = newValue }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    
//    private func setup() {
//        // 내부 텍스트 필드 추가
//        addSubview(textField)
//        NSLayoutConstraint.activate([
//            textField.topAnchor.constraint(equalTo: topAnchor, constant: padding.top),
//            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
//            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right),
//            textField.heightAnchor.constraint(equalToConstant: cellHeight)
//        ])
//        
//        // 내부 테이블 뷰 추가
//        addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//        
//        textField.delegate = self
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        tableView.isHidden = true
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        tableView.frame = CGRect(x: 0, y: textField.frame.maxY, width: bounds.width, height: 0)
//    }
//    
//    private func toggleTableView() {
//        tableView.isHidden = !tableView.isHidden
//        
//        UIView.animate(withDuration: 0.3) {
//            self.layoutSubviews()
//        }
//    }
//}
//
//extension DropDownTextField: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return options.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = options[indexPath.row]
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
//        cell.textLabel?.textColor = .black
//        cell.backgroundColor = .clear
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return cellHeight
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedOption = options[indexPath.row]
//        textField.text = selectedOption
//        toggleTableView()
//    }
//}
//
//extension DropDownTextField: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        toggleTableView()
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        toggleTableView()
//    }
//}
