//
//  MyRepository.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import Combine

protocol LocalRepository {
    func fetchCalendarEvents() -> Future<[CalendarModel], Error>
    func fetchNotification() -> Future<[NotificationModel], Error>
    func fetchMyInfo() -> Future<UserInfoModel, Error>
}






