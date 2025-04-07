//
//  MyRepositoryImpl.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import Combine

class LocalRepositoryImpl : LocalRepository {
    let dateFormatter = DateFormatter()
    init(){
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func fetchCalendarEvents() -> Future<[CalendarModel], Error> {
        return Future<[CalendarModel], Error> { [self] promise in
            // 실제 구현에서는 데이터 소스(예: 데이터베이스, API)에서 데이터를 가져와야 합니다.
            // 예시로 빈 배열이나 샘플 데이터를 반환합니다.
            let sampleEvents = [
                CalendarModel(
                    title: "팀 미팅",
                    startDate: dateFormatter.date(from: "2024-03-20")!,
                    endDate: dateFormatter.date(from: "2024-03-21")!,
                    notes: "프로젝트 미팅",
                    colorIndex: 0,
                    isAllDay: false
                )
            ]
            
            // 성공 케이스 처리
            promise(.success(sampleEvents))
            
            // 에러 케이스는 주석 처리하거나 실제 에러 처리 로직으로 대체
            // promise(.failure(SomeErrorType))
        }
    }
        
    func fetchNotification() -> Future<[NotificationModel], Error> {
        return Future<[NotificationModel], Error> { promise in
            let sampleList = [
                NotificationModel(
                    title: "새로운 업데이트 알림",
                    contentText: "앱의 최신 버전이 출시되었습니다.",
                    updateDate: "2024-03-18"
                )
            ]
            
            // 성공 케이스 처리
            promise(.success(sampleList))
        }
    }
    
    func fetchMyInfo() -> Future<UserInfoModel, Error> {
        return Future<UserInfoModel, Error> { promise in
            let sampleData = UserInfoModel(
                gender: false,
                age: 12,
                education: "대학",
                incomePerMonth: 120.1
            )
            
            // 성공 케이스 처리
            promise(.success(sampleData))
        }
    }
}
