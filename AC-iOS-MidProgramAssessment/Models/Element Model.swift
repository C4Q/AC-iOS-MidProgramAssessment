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
    let number: Int
    // to avoid the error of the computated varible from codable exclude it from  codingKeys https://stackoverflow.com/questions/44655562/how-to-exclude-properties-from-swift-4s-codable
    var imageNumber: String?{
        switch self.number.description.count {
        case 1:
            return "00\(self.number)"
        case 2:
            return "0\(self.number)"
        default:
            return "\(self.number)"
        }
    }
    let name: String
    let symbol: String
    let weight: Double
    let meltingPointDegCel: Double?
    let boilingPointDegCel: Double?
    let discoveryYearInt: Int?
    let discoveryYearStr: String?
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case name
        case symbol
        case weight
        case meltingPointDegCel = "melting_c"
        case boilingPointDegCel = "boiling_c"
        case discoveryYearInt = "discovery_year"
    }
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.id = try values.decode(Double.self, forKey: .id)
        self.number = try values.decode(Int.self, forKey: .number)
        self.symbol = try values.decode(String.self, forKey: .symbol)
        self.weight = try values.decode(Double.self, forKey: .weight)
        self.meltingPointDegCel = try values.decode(Double?.self, forKey: .meltingPointDegCel)
        self.boilingPointDegCel = try values.decode(Double?.self, forKey: .boilingPointDegCel)
        if let discoveryInt = try? values.decode(Int.self, forKey: .discoveryYearInt){
            self.discoveryYearInt = discoveryInt
        }
        else{
            self.discoveryYearInt = nil
        }
        if let discoveryStr = try? values.decode(String?.self, forKey: .discoveryYearInt){
            self.discoveryYearStr = discoveryStr
        }
        else{
            self.discoveryYearStr = nil
        }
    }
}




