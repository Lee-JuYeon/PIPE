//
//  BusinessHomeModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/07/26.
//

import Foundation

struct OfficeModel: Decodable, Hashable {
    let buildingAddress : String
    let buildingSize : Float
    let buildingPrice : Float
    let buildingPriceType : String
    let buildingType : String
    let website : String
    let target : String
    let constructionCompany : String
    let company : String
}
