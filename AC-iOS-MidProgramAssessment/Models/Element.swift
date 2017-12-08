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
    let name: String?
    let symbol: String
    let melting: Int?
    let boiling: Int?
    //let discoveryYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case number
        case weight
        case name
        case symbol
        case melting = "melting_c" //Label is the original name in the JSON
        case boiling = "boiling_c"
        //case discoveryYear = "discovery_year"
    }
}


/*{
    "id": 1,
    "record_url": "https://fieldbook.com/records/5848deac37802c0400b17c6b",
    "number": 1,
    "weight": 1.0079,
    "name": "Hydrogen",
    "symbol": "H",
    "melting_c": -259,
    "boiling_c": -253,
    "density": 0.09,
    "crust_percent": 0.14,
    "discovery_year": "1776",
    "group": 1,
    "electrons": "1s1",
    "ion_energy": 13.5984
},
{
    "id": 109,
    "record_url": "https://fieldbook.com/records/5848dead37802c0400b17cd7",
    "number": 109,
    "weight": 268,
    "name": "Meitnerium",
    "symbol": "Mt",
    "melting_c": null,
    "boiling_c": null,
    "density": null,
    "crust_percent": null,
    "discovery_year": "1982",
    "group": 9,
    "electrons": null,
    "ion_energy": null
}
 */
