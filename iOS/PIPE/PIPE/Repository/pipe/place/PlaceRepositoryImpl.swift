//
//  PlaceRepositoryImpl.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import RxSwift
import Alamofire

class PlaceRepositoryImpl : PlaceRepository {
    
    /*
     private let baseURL = "https://api.example.com" // 실제 API URL로 변경
         
         func fetchOfficeModels() -> Observable<[OfficeModel]> {
             return Observable.create { observer in
                 // Alamofire 요청
                 let request = AF.request("\(self.baseURL)/offices",
                                         method: .get)
                     .responseDecodable(of: [OfficeModel].self) { response in
                         switch response.result {
                         case .success(let officeModels):
                             observer.onNext(officeModels) // 성공 시 데이터 전달
                             observer.onCompleted()        // 완료
                         case .failure(let error):
                             observer.onError(error)       // 오류 전달
                         }
                     }
                 
                 // Disposable: 요청 취소 가능
                 return Disposables.create {
                     request.cancel()
                 }
             }
         }
     */
    
    func fetchOfficeModels() -> Observable<[OfficeModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyOfficeList)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchHomeModels() -> Observable<[HomeModel]> {
        return Observable.create { observer in
            observer.onNext(DummySingleton.shared.dummyHomeList)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
