//
//  DepositOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation
import Combine

class MemoVM: ObservableObject {
    
    private let memoRepository : MemoRepository
    init(
        setMemoRepository : MemoRepository
    ){
        memoRepository = setMemoRepository
    }
    
    private let memoSubject = PassthroughSubject<[MemoModel], Error>()
    private var memoCancellable = Set<AnyCancellable>()
    var cmemoList : AnyPublisher<[MemoModel], Error>{
        return memoSubject.eraseToAnyPublisher()
    }
    func loadMemo(){
        let fetchTask = memoRepository.fetchMemos()
        fetchTask
            .sink { completion in
                switch completion {
                case .finished:
                    print("MemoVM, loadMemo, sink // 비동기 작업이 성공적으로 끝남")
                case .failure(let error):
                    print("MemoVM, loadMemo, sink // error: \(error.localizedDescription)")
                }
            } receiveValue: { list in
                self.memoSubject.send(list)
            }
            .store(in: &memoCancellable)
    }
    
   
}
