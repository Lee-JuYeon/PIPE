//
//  CertificationModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation

struct CertificationModel : Decodable, Hashable {
    let country : String
    let name : String
    let date : Date
}
