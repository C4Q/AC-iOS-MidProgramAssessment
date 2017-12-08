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
    var discoveryYearAsInt: Int?
    var discoveryYearAsString: String?
    
    enum CodingKeys: String, CodingKey {
        case number, weight, name, symbol
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        case discoveryYearAsInt = "discovery_year"
        case discoveryYearAsString
    }
    
    //Extra Credit
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.number = try container.decode(Int.self, forKey: .number)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.meltingPoint = try container.decode(Int?.self, forKey: .meltingPoint)
        self.boilingPoint = try container.decode(Int?.self, forKey: .boilingPoint)
        
        if let int = try? container.decode(Int.self, forKey: .discoveryYearAsInt) {
            self.discoveryYearAsInt = int
        } else if let string = try? container.decode(String.self, forKey: .discoveryYearAsInt) {
            self.discoveryYearAsString = string
        }
    }
}
