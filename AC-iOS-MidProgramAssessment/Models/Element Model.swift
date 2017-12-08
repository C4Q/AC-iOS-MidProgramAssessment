//
//  Element Model.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct Element: Codable {
    let id: Double
    let number: Double
    let name: String
    let symbol: String
    let meltingPointDegCel: Double?
    let boilingPointDegCel: Double?
//    let discoveryYear: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case name
        case symbol
        case meltingPointDegCel = "melting_c"
        case boilingPointDegCel = "boiling_c"
//        case discoveryYear = "discovery_year"
    }
}
