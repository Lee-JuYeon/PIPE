//
//  ThirdOptionModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import RxSwift

protocol MemoRepository {
    func fetchMemos() -> Observable<[MemoModel]>
    func saveMemo(_ memo: MemoModel) -> Observable<MemoModel>
    func updateMemo(_ memo: MemoModel) -> Observable<MemoModel>
    func deleteMemo(id: UUID) -> Observable<Bool>
}
