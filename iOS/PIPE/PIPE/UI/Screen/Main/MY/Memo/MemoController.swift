//
//  FixedDepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/31.
//

import Foundation
import UIKit
import UIKit
import Combine

class MemoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var vm: MemoVM?
    private var tableView: UITableView!
    private var detailView: MemoDetailView!
    private var cancellables = Set<AnyCancellable>()
    private var memos: [MemoModel] = []
    
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
        tableView.register(MemoItem.self, forCellReuseIdentifier: MemoItem.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 상세 뷰 설정
        detailView = MemoDetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰 추가
        view.addSubview(tableView)
        view.addSubview(detailView)

        // 제약 조건 설정
        NSLayoutConstraint.activate([
            // 테이블 뷰 제약 조건 (1/4 너비)
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            // 상세 뷰 제약 조건 (3/4 너비)
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: tableView.trailingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBindings() {
        // ViewModel의 메모 리스트 구독
        vm?.cmemoList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("메모 로딩 완료")
                case .failure(let error):
                    print("메모 로딩 에러: \(error)")
                }
            } receiveValue: { [weak self] memos in
                self?.memos = memos
                self?.tableView.reloadData()
                
                // 첫 번째 메모 선택 (옵셔널)
                if let firstMemo = memos.first {
                    self?.detailView.configure(with: firstMemo)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoItem.identifier, for: indexPath) as? MemoItem else {
            return UITableViewCell()
        }
        
        cell.configure(with: memos[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = memos[indexPath.row]
        
        // 선택된 메모의 전체 내용을 상세 뷰에 표시
        detailView.configure(with: memo)
        
        // 셀 선택 애니메이션
        UIView.animate(withDuration: 0.3) {
            tableView.beginUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.endUpdates()
        }
    }
}

// 상세 뷰 추가 (이전 구현과 동일)
class MemoDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    func configure(with memo: MemoModel) {
        contentLabel.text = memo.content
        
        // 내용의 높이에 따라 스크롤 뷰 컨텐츠 크기 조정
        layoutIfNeeded()
        scrollView.contentSize = CGSize(
            width: scrollView.frame.width,
            height: contentLabel.frame.height + 32
        )
    }
}
