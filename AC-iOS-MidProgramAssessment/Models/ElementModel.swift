//
//  ElementModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct PeriodicElement {
    let number: Int?
    let weight: Double?
    let name: String
    let symbol: String?
    let meltingPoint: Int?
    let boilingPoint: Int?
    let discoveryYear: Int
 
    enum CodingKeys: String, CodingKey {
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        case discoveryYear = "discovery_year"
    }
}
