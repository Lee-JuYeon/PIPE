//
//  DepositResult.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation

// 메모 모델
struct MemoModel {
    let id: UUID
    let content: String
    
    // 첫 번째 줄 추출 메서드
    var firstLine: String {
        return content.components(separatedBy: .newlines).first ?? content
    }
}
