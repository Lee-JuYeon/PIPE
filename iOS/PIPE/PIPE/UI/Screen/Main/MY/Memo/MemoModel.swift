//
//  DepositResult.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/29.
//

import Foundation

struct MemoModel: Codable, Equatable, Identifiable {
    let id: UUID
    let content: String
    let createdAt: Date
    let updatedAt: Date?
    
    init(id: UUID = UUID(), content: String, createdAt: Date = Date(), updatedAt: Date? = nil) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: MemoModel, rhs: MemoModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MemoModel {
    var previewText: String {
        // 첫 번째 줄 또는 내용의 일부를 제목으로 표시
        let lines = content.split(separator: "\n", maxSplits: 1)
        let firstLine = String(lines.first ?? "")
        return firstLine.count > 30 ? firstLine.prefix(30) + "..." : firstLine
    }
    
    var firstLine: String {
        // 첫 번째 줄을 제목으로 표시
        let lines = content.split(separator: "\n", maxSplits: 1)
        return String(lines.first ?? "")
    }
}
