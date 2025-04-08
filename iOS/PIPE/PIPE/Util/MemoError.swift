//
//  LoanController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/28.
//

// 메모 관련 오류 정의
enum MemoError: Error {
    case storageError(String)
    case notFound(String)
    case decodingError(String)
}
