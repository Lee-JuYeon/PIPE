//
//  FixedDepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/31.
//

import UIKit
import RxSwift

class MemoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var vm: MemoVM?
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private var memos: [MemoModel] = []
    private var expandedIndexPathSubject = BehaviorSubject<IndexPath?>(value: nil)
    private var headerExpanded = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let memoRepository = MemoRepositoryImpl()
        vm = MemoVM(setMemoRepository: memoRepository)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoView()
        setupBindings()
        vm?.loadMemos()
    }
    
    func setupMemoView() {
        title = "메모"
        view.backgroundColor = .white
        
        // 테이블 뷰 설정
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.identifier)
        tableView.register(MemoHeaderView.self, forHeaderFooterViewReuseIdentifier: MemoHeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionHeaderHeight = 60 // 기본 헤더 높이 설정
        tableView.separatorStyle = .none
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
    
    private func setupBindings() {
        // ViewModel의 메모 리스트 구독
        vm?.memoList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] memos in
                self?.memos = memos
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // 확장된 셀 변경 이벤트 구독
        expandedIndexPathSubject
            .skip(1) // 초기값 스킵
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UITableViewDataSource
    
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
        
        // 현재 셀이 확장된 상태인지 확인
        let expandedIndexPath: IndexPath?
        do {
            expandedIndexPath = try expandedIndexPathSubject.value()
        } catch {
            expandedIndexPath = nil
        }
        
        let isExpanded = expandedIndexPath == indexPath
        cell.configure(with: memos[indexPath.row], isExpanded: isExpanded)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoHeaderView.identifier) as? MemoHeaderView else {
            return nil
        }
        
        // 새 메모 추가 버튼 클릭
        headerView.onAddButtonTap = { [weak self, weak headerView] in
            guard let self = self, let headerView = headerView else { return }
            self.headerExpanded = true
            headerView.expandView()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
        // 저장 버튼 클릭
        headerView.onSaveButtonTap = { [weak self, weak headerView] text in
            guard let self = self, let headerView = headerView else { return }
            self.vm?.addMemo(content: text)
            self.headerExpanded = false
            headerView.collapseView()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
        // 취소 버튼 클릭
        headerView.onCancelButtonTap = { [weak self, weak headerView] in
            guard let self = self, let headerView = headerView else { return }
            self.headerExpanded = false
            headerView.collapseView()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerExpanded ? 230 : 60 // 확장/축소 상태에 따라 높이 조정
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 확장된 셀인지 확인
        let expandedIndexPath: IndexPath?
        do {
            expandedIndexPath = try expandedIndexPathSubject.value()
        } catch {
            expandedIndexPath = nil
        }
        
        // 확장된 셀은 자동 높이, 나머지는 100
        return (expandedIndexPath == indexPath) ? UITableView.automaticDimension : 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleCellSelection(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func handleCellSelection(at indexPath: IndexPath) {
        // 이전에 확장된 셀이 있고, 현재 선택한 셀과 다른 경우 축소
        let previousIndexPath: IndexPath?
        do {
            previousIndexPath = try expandedIndexPathSubject.value()
        } catch {
            previousIndexPath = nil
        }
        
        if let previous = previousIndexPath, previous != indexPath {
            if let cell = tableView.cellForRow(at: previous) as? MemoCell {
                cell.toggleExpanded()
            }
        }
        
        // 현재 셀 토글
        if let cell = tableView.cellForRow(at: indexPath) as? MemoCell {
            cell.toggleExpanded()
            
            // 현재 확장된 셀 갱신
            let newValue = (previousIndexPath == indexPath) ? nil : indexPath
            expandedIndexPathSubject.onNext(newValue)
            
            // 확장된 경우 해당 셀로 스크롤
            if newValue == indexPath {
                tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
        }
        
        // 테이블 뷰 높이 업데이트
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // 스와이프로 편집/삭제 기능 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
