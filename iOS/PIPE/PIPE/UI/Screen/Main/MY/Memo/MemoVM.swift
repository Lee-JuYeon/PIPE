//
//  DepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation
import Foundation

protocol MemoVMDelegate: AnyObject {
    func didUpdateMemos(memos: [MemoModel])
    func didCompleteMemoOperation(operationType: MemoVM.OperationType, success: Bool)
}

class MemoVM {
    
    enum OperationType {
        case add
        case update
        case delete
    }
    
    private let memoRepository: MemoRepositoryImpl
    private var memos: [MemoModel] = []
    
    weak var delegate: MemoVMDelegate?
    
    init(memoRepository: MemoRepositoryImpl = MemoRepositoryImpl()) {
        self.memoRepository = memoRepository
        self.memoRepository.delegate = self
        
        // 초기 데이터 로드
        self.memos = memoRepository.fetchMemos()
    }
    
    // MARK: - Public Methods
    
    func getMemos() -> [MemoModel] {
        return memos
    }
    
    func loadMemos() {
        memos = memoRepository.fetchMemos()
        delegate?.didUpdateMemos(memos: memos)
    }
    
    func addMemo(content: String) {
        // 텍스트 유효성 검사
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedContent.isEmpty else {
            delegate?.didCompleteMemoOperation(operationType: .add, success: false)
            return
        }
        
        let newMemo = MemoModel(id: UUID(), content: trimmedContent)
        
        // 로컬 캐시 업데이트 (낙관적 업데이트)
        let updatedMemos = memos + [newMemo]
        
        // 델리게이트에 알림 (UI 업데이트)
        self.memos = updatedMemos
        delegate?.didUpdateMemos(memos: updatedMemos)
        
        // 저장소에 저장
        memoRepository.saveMemo(newMemo) { [weak self] success in
            guard let self = self else { return }
            
            if !success {
                // 저장 실패 시 이전 상태로 롤백
                self.memos = self.memoRepository.fetchMemos()
                delegate?.didUpdateMemos(memos: self.memos)
            }
            
            delegate?.didCompleteMemoOperation(operationType: .add, success: success)
        }
    }
    
    func updateMemo(id: UUID, content: String) {
        // 텍스트 유효성 검사
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedContent.isEmpty else {
            delegate?.didCompleteMemoOperation(operationType: .update, success: false)
            return
        }
        
        // 기존 메모 찾기
        guard let index = memos.firstIndex(where: { $0.id == id }) else {
            delegate?.didCompleteMemoOperation(operationType: .update, success: false)
            return
        }
        
        let updatedMemo = MemoModel(id: id, content: trimmedContent, updatedAt: Date())
        
        // 로컬 캐시 업데이트 (낙관적 업데이트)
        var updatedMemos = memos
        updatedMemos[index] = updatedMemo
        
        // 델리게이트에 알림 (UI 업데이트)
        self.memos = updatedMemos
        delegate?.didUpdateMemos(memos: updatedMemos)
        
        // 저장소에 저장
        memoRepository.updateMemo(updatedMemo) { [weak self] success in
            guard let self = self else { return }
            
            if !success {
                // 저장 실패 시 이전 상태로 롤백
                self.memos = self.memoRepository.fetchMemos()
                delegate?.didUpdateMemos(memos: self.memos)
            }
            
            delegate?.didCompleteMemoOperation(operationType: .update, success: success)
        }
    }
    
    func deleteMemo(id: UUID) {
        // 삭제할 메모의 인덱스 찾기
        guard let index = memos.firstIndex(where: { $0.id == id }) else {
            delegate?.didCompleteMemoOperation(operationType: .delete, success: false)
            return
        }
        
        // 로컬 캐시 업데이트 (낙관적 업데이트)
        var updatedMemos = memos
        updatedMemos.remove(at: index)
        
        // 델리게이트에 알림 (UI 업데이트)
        self.memos = updatedMemos
        delegate?.didUpdateMemos(memos: updatedMemos)
        
        // 저장소에서 삭제
        memoRepository.deleteMemo(id: id) { [weak self] success in
            guard let self = self else { return }
            
            if !success {
                // 삭제 실패 시 이전 상태로 롤백
                self.memos = self.memoRepository.fetchMemos()
                delegate?.didUpdateMemos(memos: self.memos)
            }
            
            delegate?.didCompleteMemoOperation(operationType: .delete, success: success)
        }
    }
    
    func searchMemos(query: String) -> [MemoModel] {
        return memoRepository.searchMemos(query: query)
    }
}

// MARK: - MemoRepositoryDelegate

extension MemoVM: MemoRepositoryDelegate {
    
    func didUpdateMemos(memos: [MemoModel]) {
        // 리포지토리에서 전체 메모 목록이 업데이트된 경우
        self.memos = memos
        delegate?.didUpdateMemos(memos: memos)
    }
    
    func didSaveMemo(memo: MemoModel, success: Bool) {
        // 필요하면 추가 작업 수행
    }
    
    func didDeleteMemo(memoID: UUID, success: Bool) {
        // 필요하면 추가 작업 수행
    }
    
    func didUpdateMemo(memo: MemoModel, success: Bool) {
        // 필요하면 추가 작업 수행
    }
}

//import Foundation
//import RxSwift
//
//class MemoVM {
//    
//    private let memoRepository: MemoRepository
//    private let _memoList = BehaviorSubject<[MemoModel]>(value: [])
//    private let disposeBag = DisposeBag()
//    
//    // 외부에서 접근 가능한 메모 리스트 Observable
//    var memoList: Observable<[MemoModel]> {
//        return _memoList.asObservable()
//    }
//    
//    init(setMemoRepository: MemoRepository) {
//        memoRepository = setMemoRepository
//    }
//    
//    func loadMemos() {
//        memoRepository.fetchMemos()
//            .subscribe(
//                onNext: { [weak self] memos in
//                    self?._memoList.onNext(memos)
//                },
//                onError: { error in
//                    print("메모 로딩 에러: \(error)")
//                }
//            )
//            .disposed(by: disposeBag)
//    }
//    
//    func addMemo(content: String) {
//        let newMemo = MemoModel(id: UUID(), content: content)
//        
//        memoRepository.saveMemo(newMemo)
//            .flatMap { [weak self] _ -> Observable<[MemoModel]> in
//                guard let self = self else { return Observable.just([]) }
//                return self.memoRepository.fetchMemos()
//            }
//            .subscribe(
//                onNext: { [weak self] memos in
//                    self?._memoList.onNext(memos)
//                },
//                onError: { error in
//                    print("메모 추가 에러: \(error)")
//                }
//            )
//            .disposed(by: disposeBag)
//    }
//    
//    func updateMemo(id: UUID, content: String) {
//        let updatedMemo = MemoModel(id: id, content: content)
//        
//        memoRepository.updateMemo(updatedMemo)
//            .flatMap { [weak self] _ -> Observable<[MemoModel]> in
//                guard let self = self else { return Observable.just([]) }
//                return self.memoRepository.fetchMemos()
//            }
//            .subscribe(
//                onNext: { [weak self] memos in
//                    self?._memoList.onNext(memos)
//                },
//                onError: { error in
//                    print("메모 업데이트 에러: \(error)")
//                }
//            )
//            .disposed(by: disposeBag)
//    }
//    
//    func deleteMemo(id: UUID) {
//        memoRepository.deleteMemo(id: id)
//            .flatMap { [weak self] _ -> Observable<[MemoModel]> in
//                guard let self = self else { return Observable.just([]) }
//                return self.memoRepository.fetchMemos()
//            }
//            .subscribe(
//                onNext: { [weak self] memos in
//                    self?._memoList.onNext(memos)
//                },
//                onError: { error in
//                    print("메모 삭제 에러: \(error)")
//                }
//            )
//            .disposed(by: disposeBag)
//    }
//}
