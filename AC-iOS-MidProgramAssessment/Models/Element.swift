//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Element: Codable {
    let id: Int
    let recordUrl: String
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let meltingC: Double?
    let boilingC: Double?
    let discoveryYear: Int?
    let discoveryYearStr: String?
    enum CodingKeys: String, CodingKey {
        case id
        case recordUrl = "record_url"
        case number
        case weight
        case name
        case symbol
        case meltingC = "melting_c"
        case boilingC = "boiling_c"
        case discoveryYear = "discovery_year"
        case discoveryYearStr
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        recordUrl = try values.decode(String.self, forKey: .recordUrl)
        number = try values.decode(Int.self, forKey: .number)
        weight = try values.decode(Double.self, forKey: .weight)
        name = try values.decode(String.self, forKey: .name)
        symbol = try values.decode(String.self, forKey: .symbol)
        meltingC = try? values.decode(Double.self, forKey: .meltingC)
        boilingC = try? values.decode(Double.self, forKey: .boilingC)
        discoveryYear = try? values.decode(Int.self, forKey: .discoveryYear)
        discoveryYearStr = try? values.decode(String.self, forKey: .discoveryYear) 
    }
}


