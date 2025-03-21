//
//  JobRepository.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import RxSwift

protocol JobRepository {
    func fetchEmploymentList() -> Observable<[EmploymentModel]>
    func fetchContestList() -> Observable<[ContestModel]>
    func fetchJobFairList() -> Observable<[JobFairModel]>
    func fetchCertificationList() -> Observable<[CertificationModel]>
}
