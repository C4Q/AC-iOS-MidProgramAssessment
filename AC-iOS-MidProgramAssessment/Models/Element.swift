//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Element: Codable {
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let meltingPointInCelsius: Int?
    let boilingPointInCelsius: Int?
//    let discoveryYear: Int?
    // some discovery years are strings "ancient"
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case number
        case weight
        case meltingPointInCelsius = "melting_c"
        case boilingPointInCelsius = "boiling_c"
//        case discoveryYear = "discovery_year"
    }
}


