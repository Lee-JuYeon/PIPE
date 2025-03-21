//
//  YeahgumModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation

struct BasicSavingModel: Codable, Hashable  {
    
    
    // 공시 제출월 [YYYYMM]
    let dcls_month: String?
    
    // 금융회사 코드
    let fin_co_no: String?
    
    // 금융 상품 code
    let fin_prdt_cd: String?
    
    // 금융회사 title
    let kor_co_nm: String?
    
    // 금융 상품명
    let fin_prdt_nm: String?
    
    // 가입 방법
    let join_way: String?
    
    // 만기 후 이자율
    let mtrt_int: String?
    
    // 우대조건
    let spcl_cnd: String?
    
    // 가입제한  Ex) 1:제한없음, 2:서민전용, 3:일부제한
    let join_deny: String?
    
    // 가입대상
    let join_member: String?
    
    // 기타 유의사항
    let etc_note: String?
    
    // 최고한도
    let max_limit: Double?
    
    // 공시 시작일
    let dcls_strt_day: String?
    
    // 공시 종료일
    let dcls_end_day: String?
    
    // 금융회사 제출일 [YYYYMMDDHH24MI]
    let fin_co_subm_day: String?
    
    // option
    let optionList : [BasicSavingResponse.Result.Option]
}
