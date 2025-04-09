//
//  FixedDepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/31.
//

import UIKit

class MemoController: UIViewController {
    
    private let memoView : MemoView = {
        let view = MemoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    init() {
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoView()
    }
    
  
    
    private func setupMemoView() {
        view.backgroundColor = .systemBackground
        
        // 뷰 추가
        view.addSubview(memoView)

        // 제약 조건 설정
        NSLayoutConstraint.activate([
            memoView.topAnchor.constraint(equalTo: view.topAnchor),
            memoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            memoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
  
}
