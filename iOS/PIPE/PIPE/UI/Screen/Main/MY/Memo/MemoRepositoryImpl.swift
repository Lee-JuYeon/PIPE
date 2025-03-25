//
//  JobVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import RxSwift
import CoreData


class MemoRepositoryImpl: MemoRepository {
    
    private let coreDataManager = MemoCoreDataManager.shared
    
    // 메모 조회
    func fetchMemos() -> Observable<[MemoModel]> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<Memo> = Memo.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
            
            do {
                let memos = try self.coreDataManager.context.fetch(fetchRequest)
                let memoModels = memos.compactMap { memo -> MemoModel? in
                    guard let id = memo.id, let content = memo.content else { return nil }
                    return MemoModel(id: id, content: content)
                }
                
                observer.onNext(memoModels)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    // 메모 저장
    func saveMemo(_ memo: MemoModel) -> Observable<MemoModel> {
        return Observable.create { observer in
            let context = self.coreDataManager.context
            let newMemo = Memo(context: context)
            
            newMemo.id = memo.id
            newMemo.content = memo.content
            newMemo.createdAt = Date()
            newMemo.updatedAt = Date()
            
            do {
                try context.save()
                observer.onNext(memo)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    // 메모 업데이트
    func updateMemo(_ memo: MemoModel) -> Observable<MemoModel> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<Memo> = Memo.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", memo.id as CVarArg)
            
            do {
                let results = try self.coreDataManager.context.fetch(fetchRequest)
                if let memoToUpdate = results.first {
                    memoToUpdate.content = memo.content
                    memoToUpdate.updatedAt = Date()
                    
                    try self.coreDataManager.context.save()
                    observer.onNext(memo)
                    observer.onCompleted()
                } else {
                    let error = NSError(domain: "MemoRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "메모를 찾을 수 없습니다."])
                    observer.onError(error)
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    // 메모 삭제
    func deleteMemo(id: UUID) -> Observable<Bool> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<Memo> = Memo.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let results = try self.coreDataManager.context.fetch(fetchRequest)
                if let memoToDelete = results.first {
                    self.coreDataManager.context.delete(memoToDelete)
                    try self.coreDataManager.context.save()
                    
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
