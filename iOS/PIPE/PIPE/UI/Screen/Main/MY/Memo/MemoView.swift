//
//  CellBankBasic.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import UIKit

class MemoView : UIView {
    private var vm: MemoVM?
    private var tableView: UITableView!
    private var memos: [MemoModel] = []
    private var expandedIndexPath: IndexPath?
    private var headerExpanded = false
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        vm = MemoVM()
        vm?.delegate = self
        
        setupMemoView()
        vm?.loadMemos()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        vm = MemoVM()
        vm?.delegate = self
        
        setupMemoView()
        vm?.loadMemos()
    }
    
    func setupMemoView() {
        // 테이블 뷰 설정
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.identifier)
        tableView.register(MemoHeaderView.self, forHeaderFooterViewReuseIdentifier: MemoHeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray  // 밑줄 색상 설정
        tableView.backgroundColor = .systemBackground
        tableView.isUserInteractionEnabled = true // 테이블 뷰 상호작용 활성화 확인
        
        // 뷰 추가
        self.addSubview(tableView)

        // 제약 조건 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    private func handleCellSelection(at indexPath: IndexPath) {
        // 테이블 뷰 높이 업데이트
        tableView.beginUpdates()
        
        // 이전에 확장된 셀이 있고, 현재 선택한 셀과 다른 경우 축소
        if let previous = expandedIndexPath, previous != indexPath {
            if let cell = tableView.cellForRow(at: previous) as? MemoCell {
                cell.toggleExpanded()
            }
        }
        
        // 현재 셀 토글
        if let cell = tableView.cellForRow(at: indexPath) as? MemoCell {
            cell.toggleExpanded()
            
            // 현재 확장된 셀 갱신
            expandedIndexPath = (expandedIndexPath == indexPath) ? nil : indexPath
            
            // 확장된 경우 해당 셀로 스크롤
            if expandedIndexPath == indexPath {
                tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
        }
        
       
        tableView.endUpdates()
    }
    
    private func showEditMemoAlert(memo: MemoModel) {
        let alert = UIAlertController(title: "메모 편집", message: "메모 내용을 수정하세요", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.text = memo.content
        }
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self, weak alert] _ in
            if let textField = alert?.textFields?.first, let text = textField.text, !text.isEmpty {
                self?.vm?.updateMemo(id: memo.id, content: text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
//        present(alert, animated: true)
    }
    

}

extension MemoView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.identifier, for: indexPath) as? MemoCell else {
            return UITableViewCell()
        }
        
        // 인덱스 범위 체크 (안전 처리)
        guard indexPath.row < memos.count else {
            return cell
        }
        
        let isExpanded = expandedIndexPath == indexPath
        cell.configure(with: memos[indexPath.row], isExpanded: isExpanded)
        cell.delegate = self // 델리게이트 설정
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoHeaderView.identifier) as? MemoHeaderView else {
            return nil
        }
        
        // 델리게이트 설정
        headerView.delegate = self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerExpanded ? 230 : 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (expandedIndexPath == indexPath) ? UITableView.automaticDimension : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택됨: \(indexPath.row)")
        
        // 인덱스 범위 체크
        guard indexPath.row < memos.count else {
            print("인덱스 범위 벗어남")
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        // 현재 선택된 셀 가져오기
        guard let cell = tableView.cellForRow(at: indexPath) as? MemoCell else {
            print("셀을 찾을 수 없음")
            return
        }
        
        // 이전에 확장된 셀이 있고, 현재 선택한 셀과 다른 경우 축소
        if let previous = expandedIndexPath, previous != indexPath,
           let previousCell = tableView.cellForRow(at: previous) as? MemoCell {
            previousCell.toggleExpanded()
        }
        
        // 현재 셀 토글
        let isSameCell = expandedIndexPath == indexPath
        expandedIndexPath = isSameCell ? nil : indexPath
        
        cell.toggleExpanded()
        
        // 확장된 경우 해당 셀로 스크롤
        if expandedIndexPath != nil {
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
        
        // 테이블 뷰 높이 업데이트
        tableView.beginUpdates()
        tableView.endUpdates()
        
        // 셀 선택 해제 (시각적 표시 제거)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 스와이프로 편집/삭제 기능 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 인덱스 범위 체크
        guard indexPath.row < memos.count else {
            return nil
        }
        
        let memo = memos[indexPath.row]
        
        // 삭제 액션만 제공
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completion) in
            self?.vm?.deleteMemo(id: memo.id)
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


extension MemoView : MemoVMDelegate {
    func didUpdateMemos(memos: [MemoModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // 데이터를 먼저 업데이트하고 그 다음 테이블 뷰를 리로드
            self.memos = memos
            
            // 전체 테이블을 다시 로드하여 데이터 불일치 문제 해결
            self.tableView.reloadData()
        }
    }
    
    func didCompleteMemoOperation(operationType: MemoVM.OperationType, success: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, !success else { return }
            
            // 에러 처리
            let title: String
            switch operationType {
            case .add: title = "메모 추가 실패"
            case .update: title = "메모 업데이트 실패"
            case .delete: title = "메모 삭제 실패"
            }
            
            let alert = UIAlertController(
                title: title,
                message: "다시 시도해주세요.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
//            self.present(alert, animated: true)
        }
    }
}

extension MemoView: MemoCellDelegate {
    func memoCellDidEndEditing(_ cell: MemoCell, memo: MemoModel, newContent: String) {
        // 메모 내용 업데이트
        vm?.updateMemo(id: memo.id, content: newContent)
    }
}


extension MemoView : MemoHeaderViewDelegate {
    func memoHeaderViewDidTapAddButton(_ headerView: MemoHeaderView) {
        headerExpanded = true
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func memoHeaderViewDidTapSaveButton(_ headerView: MemoHeaderView, text: String) {
        guard !text.isEmpty else { return }
        headerExpanded = false
        vm?.addMemo(content: text)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func memoHeaderViewDidTapCancelButton(_ headerView: MemoHeaderView) {
        headerExpanded = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}


