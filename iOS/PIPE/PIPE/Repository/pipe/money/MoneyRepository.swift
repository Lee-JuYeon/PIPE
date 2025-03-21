//
//  Repository.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/07.
//

import Foundation
import RxSwift

protocol MoneyRepository {
    func fetchBankList() -> Observable<[BankModel]>
    func fetchSupportList() -> Observable<[SupportModel]>
}
