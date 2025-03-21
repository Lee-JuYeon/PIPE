//
//  MoneyRepository.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/31.
//

import Foundation
import Alamofire
import RxSwift

class MoneyRepositoryImpl : MoneyRepository {

    
    let alamofireManager = AlamofireManager.instance
    
    // 은행 예적금
    func fetchBankList() -> Observable<[BankModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyBankModels())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    // 지원금
    func fetchSupportList() -> Observable<[SupportModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummySupportList)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
