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
    //let discovery_year: Int? coding keys stuff here
    let group: Int
    let electrons: String?
    let ion_energy: Double?
}
