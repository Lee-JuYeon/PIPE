//
//  MyRepositoryImpl.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/23.
//

import Foundation
import Combine

class LocalRepositoryImpl : LocalRepository {
    func fetchCalendarEvents() -> Future<[CalendarModel], Error> {
        return Future<[CalendarModel], Error> { promise in
            // 실제 구현에서는 데이터 소스(예: 데이터베이스, API)에서 데이터를 가져와야 합니다.
            // 예시로 빈 배열이나 샘플 데이터를 반환합니다.
            let sampleEvents = [
                CalendarModel(
                    startDate: "2024-03-20",
                    endDate: "2024-03-21",
                    simpleMemo: "프로젝트 미팅",
                    eventTitle: "팀 미팅"
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
