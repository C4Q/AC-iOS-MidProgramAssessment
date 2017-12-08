//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Caroline Cruz on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Element: Codable {
    let id: Int
    let number: Int?
    let weight: Double?
    let name: String
    let symbol: String?
    let meltingPoint: Int?
    let boilingPoint: Int?
//    let discoveryYear: Any
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case weight
        case name
        case symbol
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
//        case discoveryYear = "discovery_year"
    }
  
}



