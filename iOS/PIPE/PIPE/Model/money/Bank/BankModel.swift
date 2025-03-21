//
//  ThirdModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation

/*
 경우 1. 내가 일본 유학시 일본 데이터를 받아보는데 한국어로 보려면?
 - HTTP 헤더에 Accept-Language 필드에 값을 집어넣음
 
 let languageCode = Locale.current.languageCode // "ko", "en", "ja" 등
 let regionCode = Locale.current.regionCode     // "KR", "US", "JP" 등
 let fullLanguage = Locale.preferredLanguages[0] // "ko-KR", "en-US" 등
 */
struct BankModel: Codable, Hashable {
    let country: String        // 국가
    let bankAddress: String    // 은행주소
    let bankURL: String        // 은행 url
    let bankName: String       // 은행 이름
    let monthlySavingAmount: Int // 월마다 넣어야하는 최소 적금액
    let maxProtectionLimit: Double // 최대 보호 한도
    let applicationDeadline: Date  // 신청 말일 날짜
    let maturityDate: Date     // 만기일
    let additionalInfo: [String: String] // 기타정보
}
