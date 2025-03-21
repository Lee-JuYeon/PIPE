//
//  PlaceRepository.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import RxSwift

protocol PlaceRepository {
    func fetchOfficeModels() -> Observable<[OfficeModel]>
    func fetchHomeModels() -> Observable<[HomeModel]>
}
