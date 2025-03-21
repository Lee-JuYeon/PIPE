//
//  JobFairModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation

struct JobFairModel : Decodable, Hashable {
    let country : String
    let name : String
    let address : String
    let url : String
}
