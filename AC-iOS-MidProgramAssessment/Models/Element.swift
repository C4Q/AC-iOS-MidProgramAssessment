//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Element: Codable {
    var id: Int //1
    var recordUrl: String //"https://fieldbook.com/records/5a297580d8e38104005045e4"
    var number: Int //1
    var weight: Double //1.0079
    var name: String //"Hydrogen"
    var symbol: String //"H"
    var meltingPoint: Int? //-259
    var boilingPoint: Int? //-253
    var density: Double? //0.09
    var crustPercent: Double? //0.14
    var discoveryYearInt: Int? //1776
    var discoveryYearStr: String?
    var group: Int //1
    var electrons: String? //"1s1"
    var ionEnergy: Double? //13.5984
    
    enum CodingKeys: String, CodingKey {
        case id
        case recordUrl = "record_url"
        case number
        case weight
        case name
        case symbol
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        case density
        case crustPercent = "crust_percent"
        case discoveryYearInt = "discovery_year"
        case discoveryYearStr
        case group
        case electrons
        case ionEnergy = "ion_energy"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.recordUrl = try values.decode(String.self, forKey: .recordUrl)
        self.number = try values.decode(Int.self, forKey: .number)
        self.weight = try values.decode(Double.self, forKey: .weight)
        self.name = try values.decode(String.self, forKey: .name)
        self.symbol = try values.decode(String.self, forKey: .symbol)
        self.meltingPoint = try values.decode(Int?.self, forKey: .meltingPoint)
        self.boilingPoint = try values.decode(Int?.self, forKey: .boilingPoint)
        self.density = try values.decode(Double?.self, forKey: .density)
        self.crustPercent = try values.decode(Double?.self, forKey: .crustPercent)
        self.group = try values.decode(Int.self, forKey: .group)
        self.electrons = try values.decode(String?.self, forKey: .electrons)
        self.ionEnergy = try values.decode(Double?.self, forKey: .ionEnergy)

        if let dyStr = try? values.decode(String.self, forKey: .discoveryYearInt) {
            self.discoveryYearStr = dyStr
        } else if let dyInt = try? values.decode(Int.self, forKey: .discoveryYearInt) {
            self.discoveryYearInt = dyInt
        }
    }
    
}

struct FavElement: Codable {
    var name: String
    var favElement: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case favElement = "favorite_element"
    }
}
