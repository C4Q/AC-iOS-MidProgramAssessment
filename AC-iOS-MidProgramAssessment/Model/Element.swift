//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Element: Codable{
    let id: Int
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
//    let discovery_year: Int
}
