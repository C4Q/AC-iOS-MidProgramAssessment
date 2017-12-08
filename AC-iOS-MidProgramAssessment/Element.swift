//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct Element: Codable {
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
    //come back to discovery year later
    //let discovery_year: Int?
    var urlNumber: String {
        switch number {
        case 0..<10 :
            return "00" + "\(number)"
        case 10..<100 :
            return "0" + "\(number)"
        default :
            return "\(number)"
        }
    }
}

