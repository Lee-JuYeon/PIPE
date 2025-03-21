//
//  MyVM.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import Combine

class LocalVM {
    
    private let repository : LocalRepository
    init(
        setRepository: LocalRepository
    ) {
        repository = setRepository
    }
   
    func futureCalendarDate(delivery : @escaping (Future<[CalendarModel], Error>) -> Void){
        delivery(repository.fetchCalendarEvents())
    }
    
    func futureNotification(delivery : @escaping (Future<[NotificationModel], Error>) -> Void){
        delivery(repository.fetchNotification())
    }
    
    func futureMyInfo(delivery : @escaping (Future<UserInfoModel, Error>) -> Void){
        delivery(repository.fetchMyInfo())
    }
}
