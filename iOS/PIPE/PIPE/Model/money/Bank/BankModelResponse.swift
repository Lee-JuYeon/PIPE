//
//  YeahgumResponse.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation


struct BankModelResponse : Codable, Hashable {
    struct Result: Codable, Hashable  {
        struct Item: Codable, Hashable  {
            let dcls_month: String? // 공시 제출월 [YYYYMM]
            let fin_co_no: String? // 금융회사 코드
            let kor_co_nm: String? // 금융회사 title
            let fin_prdt_cd: String? // 금융 상품 code
            let fin_prdt_nm: String? // 금융 상품명
            let join_way: String? // 가입 방법
            let pnsn_kind : String? // 연금종류
            let pnsn_kind_nm: String? // 연금종류명
            let sale_strt_day : String? // 판매 개시일
            let mntn_cnt: String? // 유지건수[단위: 건] 또는 설정액 [단위: 원]
            let prdt_type: String? // 상품유형
            let prdt_type_nm: String?  // 상품유형명
            let dcls_rate: Float // 공시이율
            let guar_rate: String? // 최저 보증이율
            let btrm_prft_rate_1: Float // 과거 수익률1(전년도) [소수점 2자리]
            let btrm_prft_rate_2: Float // 과거 수익률2(전전년도) [소수점 2자리]
            let btrm_prft_rate_3: Float // 과거 수익률3(전전전년도) [소수점 2자리]
            let etc : String? // 기타사항
            let sale_co : String? // 판매사
            let dcls_strt_day : String? // 공시 시작일
            let dcls_end_day : String?  // 공시 종료일
            let fin_co_subm_day : String? // 금융회사 제출일 [YYYYMMDDHH24MI]
        }
        struct Option: Codable, Hashable  {
            let dcls_month: String? // 공시 제출월 [YYYYMM]
            let fin_co_no: String? // 금융회사 코드
            let fin_prdt_cd: String? // 금융상품 코드
            let pnsn_recp_trm: String?  // 연금
            let pnsn_recp_trm_nm: String? // 연금
            let pnsn_entr_age : String? // 연금
            let pnsn_entr_age_nm : String? // 연금
            let mon_paym_atm: String? // 
            let mon_paym_atm_nm: Float  //
            let paym_prd: Float //
            let paym_prd_nm: String?  //
            let pnsn_strt_age: String? // 연금
            let pnsn_strt_age_nm : String? // 연금
            let pnsn_recp_amt : String? // 연금
        }

//        struct Items : Codable, Hashable {
//            let items : [Item]
//        }
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

    let result : Result
}
