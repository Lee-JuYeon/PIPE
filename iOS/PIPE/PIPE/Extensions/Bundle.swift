//
//  PipeVMProtocol.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/07/29.
//

import Foundation

extension Bundle {
    
    var API_URL_BANK_BASIC_SAVING : String? {
        guard let file = self.path(forResource: "Keys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_URL_BANK_BASIC_SAVING"] as? String else {
            print("Bundle extention, API_URL_BANK_BASIC_SAVING // ⛔️ API KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
    var API_URL_BANK_DEPOSIT_SAVING : String? {
        guard let file = self.path(forResource: "Keys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_URL_BANK_DEPOSIT_SAVING"] as? String else {
            print("Bundle extention, API_URL_BANK_DEPOSIT_SAVING // ⛔️ API URL를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
    var API_URL_BANK_RETIREMENT_SAVING : String? {
        guard let file = self.path(forResource: "Keys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_URL_BANK_RETIREMENT_SAVING"] as? String else {
            print("Bundle extention, API_URL_BANK_RETIREMENT_SAVING // ⛔️ API URL를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
}
