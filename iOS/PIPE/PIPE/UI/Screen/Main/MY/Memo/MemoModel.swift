//
//  DepositResult.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation

// 메모 모델
struct MemoModel: Codable, Equatable {
    let id: UUID
    let content: String
    let createdAt: Date
    let updatedAt: Date?
    
    var previewText: String {
        let lines = content.split(separator: "\n", maxSplits: 1)
        let firstLine = String(lines.first ?? "")
        return firstLine.count > 30 ? firstLine.prefix(30) + "..." : firstLine
    }
    
    static func create(content: String) -> MemoModel {
        return MemoModel(id: UUID(), content: content, createdAt: Date(), updatedAt: nil)
    }
    
    func updated(content: String) -> MemoModel {
        return MemoModel(id: self.id, content: content, createdAt: self.createdAt, updatedAt: Date())
    }
}
