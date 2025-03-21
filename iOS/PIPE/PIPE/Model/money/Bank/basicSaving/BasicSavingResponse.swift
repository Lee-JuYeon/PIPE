//
//  YeahgumResponse.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation

struct BasicSavingResponse: Codable, Hashable {
    struct Result: Codable, Hashable  {
        struct Item: Codable, Hashable {
            let dcls_month: String?
            let fin_co_no: String?
            let fin_prdt_cd: String?
            let kor_co_nm: String?
            let fin_prdt_nm: String?
            let join_way: String?
            let mtrt_int: String?
            let spcl_cnd: String?
            let join_deny: String?
            let join_member: String?
            let etc_note: String?
            let max_limit: Double?
            let dcls_strt_day: String?
            let dcls_end_day: String?
            let fin_co_subm_day: String?
        }
        
        struct Option: Codable, Hashable {
            let dcls_month: String?  // 공시 제출월 [YYYYMM]
            let fin_co_no: String? // 금융회사 코드
            let fin_prdt_cd: String? // 금융상품 코드
            let intr_rate_type: String? // 저축 금리 유형
            let intr_rate_type_nm: String? // 저축 금리 유형명
            let rsrv_type : String? // 적립 유형
            let rsrv_type_nm : String? // 적립 유형명
            let save_trm: String? // 저축 기간 [단위: 개월]
            let intr_rate: Double? // 저축 금리 [소수점 2자리]
            let intr_rate2: Double? // 최고 우대금리 [소수점 2자리]
        }
        
//        struct Items : Codable, Hashable {
//            let items : [Item]
//        }
//       
//        struct Options : Codable, Hashable {
//            let options : [Option]
//        }
        
        let prdt_div: String?
        let total_count: Int
        let max_page_no: Int
        let now_page_no: Int
        let err_cd: String?
        let err_msg: String?
        let baseList: [Item]
        let optionList : [Option]
    }
    
    let result: Result
}
