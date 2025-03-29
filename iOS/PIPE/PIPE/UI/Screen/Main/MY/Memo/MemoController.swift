//
//  FixedDepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/31.
//

import UIKit
import UIKit

class MemoController: UIViewController {
    private var vm: MemoVM?
    private var tableView: UITableView!
    private var memos: [MemoModel] = []
    private var expandedIndexPath: IndexPath?
    private var headerExpanded = false
    
    // MARK: - Lifecycle Methods
    
    init() {
        super.init(nibName: nil, bundle: nil)
        vm = MemoVM()
        vm?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoView()
        vm?.loadMemos()
    }
    
    // MARK: - UI Setup
    
    func setupMemoView() {
        title = "메모"
        view.backgroundColor = .systemBackground
        
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
        
        // 뷰 추가
        view.addSubview(tableView)

        // 제약 조건 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Helper Methods
    
    private func handleCellSelection(at indexPath: IndexPath) {
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
        
        // 테이블 뷰 높이 업데이트
        tableView.beginUpdates()
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
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MemoController: UITableViewDataSource, UITableViewDelegate {
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoHeaderView.identifier) as? MemoHeaderView else {
            return nil
        }
        
        // 새 메모 추가 버튼 클릭
        headerView.onAddButtonTap = { [weak self] in
            self?.headerExpanded = true
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
        
        // 저장 버튼 클릭
        headerView.onSaveButtonTap = { [weak self] text in
            guard let self = self, !text.isEmpty else { return }
            self.headerExpanded = false
            // 메모 추가는 MemoVM에 위임하고 UI 업데이트는 델리게이트에서 처리
            self.vm?.addMemo(content: text)
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
        // 취소 버튼 클릭
        headerView.onCancelButtonTap = { [weak self] in
            guard let self = self else { return }
            self.headerExpanded = false
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerExpanded ? 230 : 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (expandedIndexPath == indexPath) ? UITableView.automaticDimension : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 인덱스 범위 체크
        guard indexPath.row < memos.count else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        handleCellSelection(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 스와이프로 편집/삭제 기능 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 인덱스 범위 체크
        guard indexPath.row < memos.count else {
            return nil
        }
        
        let memo = memos[indexPath.row]
        
        // 편집 액션
        let editAction = UIContextualAction(style: .normal, title: "편집") { [weak self] (_, _, completion) in
            self?.showEditMemoAlert(memo: memo)
            completion(true)
        }
        editAction.backgroundColor = .systemBlue
        
        // 삭제 액션
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completion) in
            self?.vm?.deleteMemo(id: memo.id)
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
}

// MARK: - MemoVMDelegate
extension MemoController: MemoVMDelegate {
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
            self.present(alert, animated: true)
        }
    }
}

//import UIKit
//import RxSwift
//
//class MemoController: UIViewController {
//    private var vm: MemoVM?
//    private var tableView: UITableView!
//    private let disposeBag = DisposeBag()
//    private var memos: [MemoModel] = []
//    private var expandedIndexPathSubject = BehaviorSubject<IndexPath?>(value: nil)
//    private var headerExpanded = false
//    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        let memoRepository = MemoRepositoryImpl()
//        vm = MemoVM(setMemoRepository: memoRepository)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupMemoView()
//        setupBindings()
//        vm?.loadMemos()
//    }
//    
//    func setupMemoView() {
//        title = "메모"
//        view.backgroundColor = .systemBackground
//        
//        // 테이블 뷰 설정
//        tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.identifier)
//        tableView.register(MemoHeaderView.self, forHeaderFooterViewReuseIdentifier: MemoHeaderView.identifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedSectionHeaderHeight = 60
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = .systemBackground
//        
//        // 뷰 추가
//        view.addSubview(tableView)
//
//        // 제약 조건 설정
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//    
//    private func setupBindings() {
//        // ViewModel의 메모 리스트 구독
//        vm?.memoList
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] memos in
//                self?.memos = memos
//                self?.tableView.reloadData()
//            })
//            .disposed(by: disposeBag)
//        
//        // 확장된 셀 변경 이벤트 구독
//        expandedIndexPathSubject
//            .skip(1) // 초기값 스킵
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] _ in
//                self?.tableView.beginUpdates()
//                self?.tableView.endUpdates()
//            })
//            .disposed(by: disposeBag)
//    }
//}
//
//// MARK: - UITableViewDataSource, UITableViewDelegate
//extension MemoController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return memos.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.identifier, for: indexPath) as? MemoCell else {
//            return UITableViewCell()
//        }
//        
//        // 현재 셀이 확장된 상태인지 확인
//        let expandedIndexPath: IndexPath?
//        do {
//            expandedIndexPath = try expandedIndexPathSubject.value()
//        } catch {
//            expandedIndexPath = nil
//        }
//        
//        let isExpanded = expandedIndexPath == indexPath
//        cell.configure(with: memos[indexPath.row], isExpanded: isExpanded)
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoHeaderView.identifier) as? MemoHeaderView else {
//            return nil
//        }
//        
//        // 새 메모 추가 버튼 클릭
//        headerView.onAddButtonTap = { [weak self] in
//            self?.headerExpanded = true
//            self?.tableView.beginUpdates()
//            self?.tableView.endUpdates()
//        }
//        
//        // 저장 버튼 클릭
//        headerView.onSaveButtonTap = { [weak self] text in
//            guard let self = self else { return }
//            self.vm?.addMemo(content: text)
//            self.headerExpanded = false
//            self.tableView.beginUpdates()
//            self.tableView.endUpdates()
//        }
//        
//        // 취소 버튼 클릭
//        headerView.onCancelButtonTap = { [weak self] in
//            guard let self = self else { return }
//            self.headerExpanded = false
//            self.tableView.beginUpdates()
//            self.tableView.endUpdates()
//        }
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return headerExpanded ? 230 : 60
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // 확장된 셀인지 확인
//        let expandedIndexPath: IndexPath?
//        do {
//            expandedIndexPath = try expandedIndexPathSubject.value()
//        } catch {
//            expandedIndexPath = nil
//        }
//        
//        // 확장된 셀은 자동 높이, 나머지는 100
//        return (expandedIndexPath == indexPath) ? UITableView.automaticDimension : 100
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        handleCellSelection(at: indexPath)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    private func handleCellSelection(at indexPath: IndexPath) {
//        // 이전에 확장된 셀이 있고, 현재 선택한 셀과 다른 경우 축소
//        let previousIndexPath: IndexPath?
//        do {
//            previousIndexPath = try expandedIndexPathSubject.value()
//        } catch {
//            previousIndexPath = nil
//        }
//        
//        if let previous = previousIndexPath, previous != indexPath {
//            if let cell = tableView.cellForRow(at: previous) as? MemoCell {
//                cell.toggleExpanded()
//            }
//        }
//        
//        // 현재 셀 토글
//        if let cell = tableView.cellForRow(at: indexPath) as? MemoCell {
//            cell.toggleExpanded()
//            
//            // 현재 확장된 셀 갱신
//            let newValue = (previousIndexPath == indexPath) ? nil : indexPath
//            expandedIndexPathSubject.onNext(newValue)
//            
//            // 확장된 경우 해당 셀로 스크롤
//            if newValue == indexPath {
//                tableView.scrollToRow(at: indexPath, at: .none, animated: true)
//            }
//        }
//        
//        // 테이블 뷰 높이 업데이트
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//    
//    // 스와이프로 편집/삭제 기능 추가
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let memo = memos[indexPath.row]
//        
//        // 편집 액션
//        let editAction = UIContextualAction(style: .normal, title: "편집") { [weak self] (_, _, completion) in
//            self?.showEditMemoAlert(memo: memo)
//            completion(true)
//        }
//        editAction.backgroundColor = .systemBlue
//        
//        // 삭제 액션
//        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completion) in
//            self?.vm?.deleteMemo(id: memo.id)
//            completion(true)
//        }
//        
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
//        return configuration
//    }
//    
//    private func showEditMemoAlert(memo: MemoModel) {
//        let alert = UIAlertController(title: "메모 편집", message: "메모 내용을 수정하세요", preferredStyle: .alert)
//        
//        alert.addTextField { textField in
//            textField.text = memo.content
//        }
//        
//        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self, weak alert] _ in
//            if let textField = alert?.textFields?.first, let text = textField.text, !text.isEmpty {
//                self?.vm?.updateMemo(id: memo.id, content: text)
//            }
//        }
//        
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//        
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true)
//    }
//}
