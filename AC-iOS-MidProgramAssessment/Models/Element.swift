//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Element: Codable {
    let id: Int
    let record_url: String
    let number: Int
    let weight: Double
    let name:  String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
    let density: Double?
    let crust_percent: Double?
    let group: Int
    let electrons: String?
    let ion_energy: Double?
    var discovery_year_int: Int?
    var discovery_year_Str: String?
    

    enum CodingKeys: String, CodingKey {
        case id
        case record_url
        case number
        case weight
        case name
        case symbol
        case melting_c
        case boiling_c
        case density
        case crust_percent
        case group
        case electrons
        case ion_energy
        case discovery_year_int = "discovery_year"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.record_url = try values.decode(String.self, forKey: .record_url)
        self.number = try values.decode(Int.self, forKey: .number)
        self.weight = try values.decode(Double.self, forKey: .weight)
        self.name = try values.decode(String.self, forKey: .name)
        self.symbol = try values.decode(String.self, forKey: .symbol)
        self.melting_c = try values.decode(Int?.self, forKey: .melting_c)
        self.boiling_c = try values.decode(Int?.self, forKey: .boiling_c)
        self.density = try values.decode(Double?.self, forKey: .density)
        self.crust_percent = try values.decode(Double?.self, forKey: .crust_percent)
        self.group = try values.decode(Int.self, forKey: .group)
        self.electrons = try values.decode(String?.self, forKey: .electrons)
        self.ion_energy = try values.decode(Double?.self, forKey: .ion_energy)

        if let yearStr = try? values.decode(String?.self, forKey: .discovery_year_int) {
            self.discovery_year_Str = yearStr
        } else if let yearInt = try? values.decode(Int?.self, forKey: .discovery_year_int) {
            self.discovery_year_int = yearInt
        }
    }
}
