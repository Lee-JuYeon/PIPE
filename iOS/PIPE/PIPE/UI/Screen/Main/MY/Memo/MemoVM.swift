//
//  DepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation
import RxSwift

class MemoVM {
    
    private let memoRepository: MemoRepository
    private let _memoList = BehaviorSubject<[MemoModel]>(value: [])
    private let disposeBag = DisposeBag()
    
    // 외부에서 접근 가능한 메모 리스트 Observable
    var memoList: Observable<[MemoModel]> {
        return _memoList.asObservable()
    }
    
    init(setMemoRepository: MemoRepository) {
        memoRepository = setMemoRepository
    }
    
    func loadMemo() {
        memoRepository.fetchMemos()
            .subscribe(
                onNext: { [weak self] memos in
                    self?._memoList.onNext(memos)
                },
                onError: { error in
                    print("메모 로딩 에러: \(error)")
                },
                onCompleted: {
                    print("메모 로딩 완료")
                }
            )
            .disposed(by: disposeBag)
    }
}
