//
//  JobVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import RxSwift

class MemoRepositoryImpl : MemoRepository {
    
    func fetchMemos() -> Observable<[MemoModel]> {
        return Observable.create { observer in
            // 더미 데이터 생성
            let memos: [MemoModel] = [
                MemoModel(id: UUID(), content: "첫 번째 메모\n여러 줄로 작성된 내용입니다.\n추가 설명도 포함됩니다."),
                MemoModel(id: UUID(), content: "두 번째 메모\n이것은 짧은 메모입니다."),
                MemoModel(id: UUID(), content: "장문의 메모\n여기에는 매우 긴 텍스트가 들어갈 수 있습니다.\n여러 줄에 걸쳐 작성된 메모의 예시입니다.\n내용이 매우 길어서 스크롤이 필요할 수 있습니다.\n이렇게 여러 줄의 텍스트를 포함할 수 있습니다.")
            ]
            
            // 데이터 방출
            observer.onNext(memos)
            
            // 스트림 완료
            observer.onCompleted()
            
            // 구독 취소 시 정리 작업
            return Disposables.create()
        }
    }
}
