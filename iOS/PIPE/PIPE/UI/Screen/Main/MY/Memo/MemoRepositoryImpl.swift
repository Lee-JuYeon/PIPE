//
//  JobVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import RxSwift

class MemoRepositoryImpl: MemoRepository {
    
    private let coreManager: MemoCoreManager
    private let disposeBag = DisposeBag()
    
    init(coreManager: MemoCoreManager = MemoCoreManager.shared) {
        self.coreManager = coreManager
    }
    
    func fetchMemos() -> Observable<[MemoModel]> {
        return coreManager.fetchMemos()
            .do(onNext: { memos in
                print("메모 \(memos.count)개 로드 완료")
            })
    }
    
    func saveMemo(_ memo: MemoModel) -> Observable<Bool> {
        return coreManager.saveMemo(memo)
    }
    
    func deleteMemo(id: UUID) -> Observable<Bool> {
        return coreManager.deleteMemo(id: id)
    }
    
    func updateMemo(_ memo: MemoModel) -> Observable<Bool> {
        return coreManager.updateMemo(memo)
    }
    
    // 일괄 처리 기능
    func batchUpdateMemos(_ memos: [MemoModel]) -> Observable<Bool> {
        let observables = memos.map { updateMemo($0) }
        
        return Observable.merge(observables)
            .toArray()
            .map { results in
                return results.allSatisfy { $0 }
            }
            .asObservable()
    }
    
    // 검색 기능
    func searchMemos(query: String) -> Observable<[MemoModel]> {
        return fetchMemos()
            .map { memos in
                return memos.filter { memo in
                    memo.content.lowercased().contains(query.lowercased())
                }
            }
    }
}
