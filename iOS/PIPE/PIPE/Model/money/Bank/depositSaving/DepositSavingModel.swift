//
//  FixedDepositResponse.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/30.
//

import Foundation
struct DepositSavingModel: Codable, Hashable {
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
    var optionList: [DepositSavingOptionModel]

    // 이니셜라이저 추가
    init(
        dcls_month: String? = nil,
        fin_co_no: String? = nil,
        fin_prdt_cd: String? = nil,
        kor_co_nm: String? = nil,
        fin_prdt_nm: String? = nil,
        join_way: String? = nil,
        mtrt_int: String? = nil,
        spcl_cnd: String? = nil,
        join_deny: String? = nil,
        join_member: String? = nil,
        etc_note: String? = nil,
        max_limit: Float? = nil,
        dcls_strt_day: String? = nil,
        dcls_end_day: String? = nil,
        fin_co_subm_day: String? = nil,
        optionList: [DepositSavingOptionModel] = []
    ) {
        self.dcls_month = dcls_month
        self.fin_co_no = fin_co_no
        self.fin_prdt_cd = fin_prdt_cd
        self.kor_co_nm = kor_co_nm
        self.fin_prdt_nm = fin_prdt_nm
        self.join_way = join_way
        self.mtrt_int = mtrt_int
        self.spcl_cnd = spcl_cnd
        self.join_deny = join_deny
        self.join_member = join_member
        self.etc_note = etc_note
        self.max_limit = max_limit
        self.dcls_strt_day = dcls_strt_day
        self.dcls_end_day = dcls_end_day
        self.fin_co_subm_day = fin_co_subm_day
        self.optionList = optionList
    }
    
    // DepositSavingResponse의 Model에서 변환하는 이니셜라이저 추가
    init(
        from baseModel: DepositSavingResponse.Result.Model,
        optionList: [DepositSavingResponse.Result.Option]
    ) {
        self.dcls_month = baseModel.dcls_month
        self.fin_co_no = baseModel.fin_co_no
        self.fin_prdt_cd = baseModel.fin_prdt_cd
        self.kor_co_nm = baseModel.kor_co_nm
        self.fin_prdt_nm = baseModel.fin_prdt_nm
        self.join_way = baseModel.join_way
        self.mtrt_int = baseModel.mtrt_int
        self.spcl_cnd = baseModel.spcl_cnd
        self.join_deny = baseModel.join_deny
        self.join_member = baseModel.join_member
        self.etc_note = baseModel.etc_note
        self.max_limit = baseModel.max_limit
        self.dcls_strt_day = baseModel.dcls_strt_day
        self.dcls_end_day = baseModel.dcls_end_day
        self.fin_co_subm_day = baseModel.fin_co_subm_day
        
        // 해당 상품의 옵션만 필터링하여 DepositSavingOptionModel로 변환
        self.optionList = optionList
            .filter { $0.fin_prdt_cd == baseModel.fin_prdt_cd }
            .map { DepositSavingOptionModel(from: $0) }
    }
}

struct DepositSavingOptionModel: Codable, Hashable {
    let dcls_month: String?
    let fin_co_no: String?
    let fin_prdt_cd: String?
    let intr_rate_type: String?
    let intr_rate_type_nm: String?
    let save_trm: String?
    let intr_rate: Float?
    let intr_rate2: Float?
    
    // DepositSavingResponse의 Option에서 변환하는 이니셜라이저 추가
    init(from option: DepositSavingResponse.Result.Option) {
        self.dcls_month = option.dcls_month
        self.fin_co_no = option.fin_co_no
        self.fin_prdt_cd = option.fin_prdt_cd
        self.intr_rate_type = option.intr_rate_type
        self.intr_rate_type_nm = option.intr_rate_type_nm
        self.save_trm = option.save_trm
        self.intr_rate = option.intr_rate
        self.intr_rate2 = option.intr_rate2
    }
}
