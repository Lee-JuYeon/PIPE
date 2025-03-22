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
        vm?.loadMemo()
    }
    
    func setupMemoView() {
        view.backgroundColor = .white
        
        // 테이블 뷰 설정
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 확장된 셀은 더 큰 높이, 나머지는 기본 높이
        return UITableView.automaticDimension
    }
}
