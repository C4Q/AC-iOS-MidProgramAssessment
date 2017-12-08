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
//    let discoveryYear: String?
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case name
        case symbol
        case weight
        case meltingPointDegCel = "melting_c"
        case boilingPointDegCel = "boiling_c"
//        case discoveryYear = "discovery_year"
    }
}
