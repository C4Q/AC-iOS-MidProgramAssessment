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
    let meltingPoint: Int?
    let boilingPoint: Int?
    let discoveryYear: toString
    
    enum CodingKeys: String, CodingKey {
        case number
        case weight
        case name
        case symbol
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        case discoveryYear = "discovery_year"
    }
    
    
}
//from: https://stackoverflow.com/questions/47318737/how-do-i-handle-decoding-two-possible-types-for-one-key-in-swift
enum toString: Codable {
    case int(Int), string(String)
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(self)")
    }
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw toString.missingValue
    }
    enum toString:Error {
        case missingValue
    }
}

