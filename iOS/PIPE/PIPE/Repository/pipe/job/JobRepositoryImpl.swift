//
//  JobRepositoryImpl.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import RxSwift
import Alamofire

class JobRepositoryImpl : JobRepository {

    let alamofireManager = AlamofireManager.instance

    func fetchEmploymentList() -> Observable<[EmploymentModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyEmploymentList())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchContestList() -> Observable<[ContestModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyContestList())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchJobFairList() -> Observable<[JobFairModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyJobFair())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchCertificationList() -> Observable<[CertificationModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyCertificationList())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    
}
