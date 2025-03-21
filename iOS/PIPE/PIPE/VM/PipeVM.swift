//
//  PipeVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/07.
//

import Foundation
import RxSwift

// Combine only, no Rx
class PipeVM {
    
    private let moneyRepository : MoneyRepository
    private let jobRepository : JobRepository
    private let placeRepository : PlaceRepository

    // Outputs
    let bankList: Observable<[BankModel]>
    let supportList: Observable<[SupportModel]>
    
    let certificationList: Observable<[CertificationModel]>
    let jobFairList: Observable<[JobFairModel]>
    let employmentList: Observable<[EmploymentModel]>
    let contestList: Observable<[ContestModel]>
    
    
    let officeList : Observable<[OfficeModel]>
    let homeList : Observable<[HomeModel]>
    
    private let disposeBag = DisposeBag()
    
    init(
        setMoneyRepository: MoneyRepository,
        setJobRepository: JobRepository,
        setPlaceRepository: PlaceRepository
    ) {
        moneyRepository = setMoneyRepository
        jobRepository = setJobRepository
        placeRepository = setPlaceRepository
        
        // Repository에서 데이터를 가져와 Output으로 제공
        bankList = moneyRepository.fetchBankList()
        supportList = moneyRepository.fetchSupportList()
        
        certificationList = jobRepository.fetchCertificationList()
        jobFairList = jobRepository.fetchJobFairList()
        employmentList = jobRepository.fetchEmploymentList()
        contestList = jobRepository.fetchContestList()
        
        officeList = placeRepository.fetchOfficeModels()
        homeList = placeRepository.fetchHomeModels()
    }
    
    
    
}
