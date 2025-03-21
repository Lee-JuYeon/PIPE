//
//  HomeModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/07/26.
//

import Foundation


struct HomeModel: Decodable, Hashable {
    let homeAddress : String
    let homeSize : Float
    let homePrice : Float
    let homePriceType : String
    let homeType : String
    let website : String
    let target : String
    let constructionCompany : String
    let company : String
}

