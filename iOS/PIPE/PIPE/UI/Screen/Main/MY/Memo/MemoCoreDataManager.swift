//
//  SavingController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/28.
//

import CoreData
import RxSwift

class MemoCoreManager {
    static let shared = MemoCoreManager()
    private let disposeBag = DisposeBag()
    
    // 메모리 캐싱
    private var memosCache: [MemoModel] = []
    private var memosCacheSubject = BehaviorSubject<[MemoModel]>(value: [])
    
    private init() {
        // 초기화 시 캐시 로드
        loadFromStorage()
            .subscribe(onNext: { [weak self] memos in
                self?.memosCache = memos
                self?.memosCacheSubject.onNext(memos)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadFromStorage() -> Observable<[MemoModel]> {
        return Observable.create { observer in
            if let data = UserDefaults.standard.data(forKey: "memos") {
                do {
                    let memos = try JSONDecoder().decode([MemoModel].self, from: data)
                    observer.onNext(memos)
                } catch {
                    print("메모 로드 에러: \(error)")
                    observer.onNext([])
                }
            } else {
                observer.onNext([])
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func saveToStorage() -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(MemoError.storageError("인스턴스 없음"))
                return Disposables.create()
            }
            
            do {
                let data = try JSONEncoder().encode(self.memosCache)
                UserDefaults.standard.set(data, forKey: "memos")
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(MemoError.storageError("저장 실패: \(error)"))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchMemos() -> Observable<[MemoModel]> {
        return memosCacheSubject.asObservable()
    }
    
    func saveMemo(_ memo: MemoModel) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(MemoError.storageError("인스턴스 없음"))
                return Disposables.create()
            }
            
            if let index = self.memosCache.firstIndex(where: { $0.id == memo.id }) {
                self.memosCache[index] = memo
            } else {
                self.memosCache.append(memo)
            }
            
            self.memosCacheSubject.onNext(self.memosCache)
            
            self.saveToStorage()
                .subscribe(onNext: { success in
                    observer.onNext(success)
                    observer.onCompleted()
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func deleteMemo(id: UUID) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(MemoError.storageError("인스턴스 없음"))
                return Disposables.create()
            }
            
            self.memosCache.removeAll { $0.id == id }
            self.memosCacheSubject.onNext(self.memosCache)
            
            self.saveToStorage()
                .subscribe(onNext: { success in
                    observer.onNext(success)
                    observer.onCompleted()
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func updateMemo(_ memo: MemoModel) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(MemoError.storageError("인스턴스 없음"))
                return Disposables.create()
            }
            
            if let index = self.memosCache.firstIndex(where: { $0.id == memo.id }) {
                self.memosCache[index] = memo
                self.memosCacheSubject.onNext(self.memosCache)
                
                self.saveToStorage()
                    .subscribe(onNext: { success in
                        observer.onNext(success)
                        observer.onCompleted()
                    }, onError: { error in
                        observer.onError(error)
                    })
                    .disposed(by: self.disposeBag)
            } else {
                observer.onError(MemoError.notFound("해당 ID의 메모 없음"))
            }
            
            return Disposables.create()
        }
    }
}
