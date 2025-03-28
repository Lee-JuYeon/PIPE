//
//  JobVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation

protocol MemoRepositoryDelegate: AnyObject {
    func didUpdateMemos(memos: [MemoModel])
    func didSaveMemo(memo: MemoModel, success: Bool)
    func didDeleteMemo(memoID: UUID, success: Bool)
    func didUpdateMemo(memo: MemoModel, success: Bool)
}

// 선택적으로 구현 가능하도록 기본 구현 제공
extension MemoRepositoryDelegate {
    func didUpdateMemos(memos: [MemoModel]) {}
    func didSaveMemo(memo: MemoModel, success: Bool) {}
    func didDeleteMemo(memoID: UUID, success: Bool) {}
    func didUpdateMemo(memo: MemoModel, success: Bool) {}
}

class MemoRepositoryImpl {
    
    private let coreManager: MemoCoreManager
    weak var delegate: MemoRepositoryDelegate?
    
    init(coreManager: MemoCoreManager = MemoCoreManager.shared) {
        self.coreManager = coreManager
        
        // NotificationCenter 옵저버 등록
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        // 메모 목록 업데이트 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemosUpdated(_:)),
            name: MemoCoreManager.NotificationNames.memosUpdated,
            object: nil
        )
        
        // 메모 저장 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoSaved(_:)),
            name: MemoCoreManager.NotificationNames.memoSaved,
            object: nil
        )
        
        // 메모 삭제 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoDeleted(_:)),
            name: MemoCoreManager.NotificationNames.memoDeleted,
            object: nil
        )
        
        // 메모 업데이트 알림 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoUpdated(_:)),
            name: MemoCoreManager.NotificationNames.memoUpdated,
            object: nil
        )
    }
    
    // 알림 처리 메서드들
    @objc private func handleMemosUpdated(_ notification: Notification) {
        if let memos = notification.userInfo?["memos"] as? [MemoModel] {
            delegate?.didUpdateMemos(memos: memos)
        }
    }
    
    @objc private func handleMemoSaved(_ notification: Notification) {
        if let memo = notification.userInfo?["memo"] as? MemoModel,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didSaveMemo(memo: memo, success: success)
        }
    }
    
    @objc private func handleMemoDeleted(_ notification: Notification) {
        if let memoID = notification.userInfo?["memoID"] as? UUID,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didDeleteMemo(memoID: memoID, success: success)
        }
    }
    
    @objc private func handleMemoUpdated(_ notification: Notification) {
        if let memo = notification.userInfo?["memo"] as? MemoModel,
           let success = notification.userInfo?["success"] as? Bool {
            delegate?.didUpdateMemo(memo: memo, success: success)
        }
    }
    
    deinit {
        // 메모리에서 해제될 때 옵저버 제거
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 공개 API
    
    // 현재 메모 목록 가져오기
    func fetchMemos() -> [MemoModel] {
        return coreManager.getMemos()
    }
    
    // 메모 저장하기
    func saveMemo(_ memo: MemoModel, completion: ((Bool) -> Void)? = nil) {
        coreManager.saveMemo(memo, completion: completion)
    }
    
    // 메모 삭제하기
    func deleteMemo(id: UUID, completion: ((Bool) -> Void)? = nil) {
        coreManager.deleteMemo(id: id, completion: completion)
    }
    
    // 메모 업데이트하기
    func updateMemo(_ memo: MemoModel, completion: ((Bool) -> Void)? = nil) {
        coreManager.updateMemo(memo, completion: completion)
    }
    
    // 검색 기능 (로컬에서 처리)
    func searchMemos(query: String) -> [MemoModel] {
        let memos = coreManager.getMemos()
        if query.isEmpty {
            return memos
        }
        
        return memos.filter { memo in
            memo.content.lowercased().contains(query.lowercased())
        }
    }
}

//import Foundation
//import RxSwift
//
//class MemoRepositoryImpl: MemoRepository {
//    
//    private let coreManager: MemoCoreManager
//    private let disposeBag = DisposeBag()
//    
//    init(coreManager: MemoCoreManager = MemoCoreManager.shared) {
//        self.coreManager = coreManager
//    }
//    
//    func fetchMemos() -> Observable<[MemoModel]> {
//        return coreManager.fetchMemos()
//            .do(onNext: { memos in
//                print("메모 \(memos.count)개 로드 완료")
//            })
//    }
//    
//    func saveMemo(_ memo: MemoModel) -> Observable<Bool> {
//        return coreManager.saveMemo(memo)
//    }
//    
//    func deleteMemo(id: UUID) -> Observable<Bool> {
//        return coreManager.deleteMemo(id: id)
//    }
//    
//    func updateMemo(_ memo: MemoModel) -> Observable<Bool> {
//        return coreManager.updateMemo(memo)
//    }
//    
//    // 일괄 처리 기능
//    func batchUpdateMemos(_ memos: [MemoModel]) -> Observable<Bool> {
//        let observables = memos.map { updateMemo($0) }
//        
//        return Observable.merge(observables)
//            .toArray()
//            .map { results in
//                return results.allSatisfy { $0 }
//            }
//            .asObservable()
//    }
//    
//    // 검색 기능
//    func searchMemos(query: String) -> Observable<[MemoModel]> {
//        return fetchMemos()
//            .map { memos in
//                return memos.filter { memo in
//                    memo.content.lowercased().contains(query.lowercased())
//                }
//            }
//    }
//}
