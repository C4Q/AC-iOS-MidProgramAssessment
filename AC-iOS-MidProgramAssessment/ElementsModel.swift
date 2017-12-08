//
//  ElementsModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Maryann Yin on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ElementsInfo: Codable {
    let elementDetails: ElementWrapper
}

struct ElementWrapper: Codable {
    let id: Int // 1
    let recordURL: String // "https://fieldbook.com/records/5a297580d8e38104005045e4"
    let number: Int // 1
    let weight: Double // 1.0079
    let name: String // "Hydrogen"
    let symbol: String // "H"
    let meltingPointInC: Int? // -259
    let boilingPointInC: Int? // -253
    let group: Int // 1
    enum CodingKeys: String, CodingKey {
        case id
        case recordURL = "record_url"
        case number
        case weight
        case name
        case symbol
        case meltingPointInC = "meling_c"
        case boilingPointInC = "boiling_c"
        case group
    }
}
