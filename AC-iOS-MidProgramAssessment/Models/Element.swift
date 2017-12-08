//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Element: Codable {
    let id: Int?
    let name: String
    let symbol: String
    let weight: Double
    let boiling_c: Double?
    let melting_c: Double?
//    let discovery_year: Int?
}
