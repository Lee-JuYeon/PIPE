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
    
    func loadMemos() {
        memoRepository.fetchMemos()
            .subscribe(
                onNext: { [weak self] memos in
                    self?._memoList.onNext(memos)
                },
                onError: { error in
                    print("메모 로딩 에러: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func addMemo(content: String) {
        let newMemo = MemoModel(id: UUID(), content: content)
        
        memoRepository.saveMemo(newMemo)
            .flatMap { [weak self] _ -> Observable<[MemoModel]> in
                guard let self = self else { return Observable.just([]) }
                return self.memoRepository.fetchMemos()
            }
            .subscribe(
                onNext: { [weak self] memos in
                    self?._memoList.onNext(memos)
                },
                onError: { error in
                    print("메모 추가 에러: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func updateMemo(id: UUID, content: String) {
        let updatedMemo = MemoModel(id: id, content: content)
        
        memoRepository.updateMemo(updatedMemo)
            .flatMap { [weak self] _ -> Observable<[MemoModel]> in
                guard let self = self else { return Observable.just([]) }
                return self.memoRepository.fetchMemos()
            }
            .subscribe(
                onNext: { [weak self] memos in
                    self?._memoList.onNext(memos)
                },
                onError: { error in
                    print("메모 업데이트 에러: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func deleteMemo(id: UUID) {
        memoRepository.deleteMemo(id: id)
            .flatMap { [weak self] _ -> Observable<[MemoModel]> in
                guard let self = self else { return Observable.just([]) }
                return self.memoRepository.fetchMemos()
            }
            .subscribe(
                onNext: { [weak self] memos in
                    self?._memoList.onNext(memos)
                },
                onError: { error in
                    print("메모 삭제 에러: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}
