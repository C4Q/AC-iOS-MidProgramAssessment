//
//  Elements.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Clint Mejia on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

// tried to get the discovery year to populate via coding keys

struct Elements: Codable {
    let number: Int
    let name: String
    let symbol: String
//    let discoveryYearStr: String?
//    let discoveryYearInt: Int?
    let weight: Double
    let melting_c: Int?
    let boiling_c: Int?
    var threeDigitNumber: String {
        guard String(number).count != 3 else { return String(number) }
        let currentLength = String(number).count == 2 ? "0\(number)" : "00\(number)"
        return currentLength

    }
    
    
    var thumbnailImageUrl: String {
        return "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitNumber)/s7.JPG"
    }
//
//    enum CodingKeys: String, CodingKey {
//        case number, name, symbol, weight, melting_c, boiling_c
//        case discoveryYearInt = "discovery_year"
//        //case postCodeStr
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decode(String.self, forKey: .name)
//        number = try values.decode(Int.self, forKey: .number)
//        symbol = try values.decode(String.self, forKey: .symbol)
//        weight = try values.decode(Double.self, forKey: .weight)
//        melting_c = try values.decode(Int.self, forKey: .melting_c)
//        boiling_c = try values.decode(Int.self, forKey: .boiling_c)
//        if let discoveryStr = try? values.decode(String.self, forKey: .discoveryYearInt) {
//            self.discoveryYearStr = discoveryStr
//        } else if let discoveryInt = try? values.decode(Int.self, forKey: .discoveryYearInt) {
//            self.discoveryYearInt = discoveryInt
//        }
//    }

    
}
