//
//  DepositProductResponse.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation

struct DepositSavingResponse: Codable, Hashable  {
    let result: Result
    
    struct Result: Codable, Hashable  {
        struct Model: Codable, Hashable {
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
            let max_limit: Float?
            let dcls_strt_day: String?
            let dcls_end_day: String?
            let fin_co_subm_day: String?
        }

        struct Option: Codable, Hashable  {
            // 공시 제출월 [YYYYMM]
            let dcls_month: String?
            
            // 금융회사 코드
            let fin_co_no: String?
            
            // 금융상품 코드
            let fin_prdt_cd: String?
            
            // 저축 금리 유형
            let intr_rate_type: String?
            
            // 저축 금리 유형명
            let intr_rate_type_nm: String?
            
            // 저축 기간 [단위: 개월]
            let save_trm: String?
            
            // 저축 금리 [소수점 2자리]
            let intr_rate: Float?
            
            // 최고 우대금리 [소수점 2자리]
            let intr_rate2: Float?

        }
        
        let prdt_div: String?
        let total_count: Int
        let max_page_no: Int
        let now_page_no: Int
        let err_cd: String?
        let err_msg: String?
        let baseList: [Model]
        let optionList : [Option]
    }
    
    
    
}
