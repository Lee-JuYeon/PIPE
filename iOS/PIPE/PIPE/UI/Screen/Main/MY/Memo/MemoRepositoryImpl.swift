//
//  JobVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import Combine

class MemoRepositoryImpl : MemoRepository {
    
    func fetchMemos() -> Future<[MemoModel], Error> {
        return Future<[MemoModel], Error> { promise in
            
            var memos: [MemoModel] = [
                MemoModel(id: UUID(), content: "첫 번째 메모\n여러 줄로 작성된 내용입니다.\n추가 설명도 포함됩니다."),
                MemoModel(id: UUID(), content: "두 번째 메모\n이것은 짧은 메모입니다."),
                MemoModel(id: UUID(), content: "장문의 메모\n여기에는 매우 긴 텍스트가 들어갈 수 있습니다.\n여러 줄에 걸쳐 작성된 메모의 예시입니다.\n내용이 매우 길어서 스크롤이 필요할 수 있습니다.\n이렇게 여러 줄의 텍스트를 포함할 수 있습니다.")
            ]
            
            
            
            // 성공 케이스 처리
            promise(.success(memos))
            
            // 에러 케이스는 주석 처리하거나 실제 에러 처리 로직으로 대체
            // promise(.failure(SomeErrorType))
        }
    }
}
