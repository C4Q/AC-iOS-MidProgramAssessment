//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Masai Young on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ThreeDigitFormatter {
    static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.positiveFormat = "000"
        return formatter
    }()
}

struct Element: Codable {
    let boilingC: Int?
    let crustPercent: Double?
    let density: Double?
    let discoveryYear: DiscoveryYear
    let electrons: String?
    let group: Int
    let id: Int
    let ionEnergy: Double?
    let meltingC: Int?
    let name: String
    let number: Int
    let recordUrl: String
    let symbol: String
    let weight: Double
    
    static let endpoint = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
    
    var smallImageEndpoint: String {
        let threeDigitId = ThreeDigitFormatter.formatter.string(from: NSNumber(value: self.id)) ?? "000"
        return "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitId)/s7.JPG"
    }
    
    var largeImageEndpoint: String {
        let elementNameLowercased = self.name.lowercased()
        return "http://images-of-elements.com/\(elementNameLowercased).jpg"
    }
    
    
}

enum DiscoveryYear: Codable {
    case integer(Int)
    case string(String)
}

extension DiscoveryYear {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int = try? container.decode(Int.self) {
            self = .integer(int)
            return
        }
        if let str = try? container.decode(String.self) {
            self = .string(str)
            return
        }
        throw DecodingError.typeMismatch(DiscoveryYear.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "DiscoveryYear is not Int or String."))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
}

extension Element {
    enum CodingKeys: String, CodingKey {
        case boilingC = "boiling_c"
        case crustPercent = "crust_percent"
        case density = "density"
        case discoveryYear = "discovery_year"
        case electrons = "electrons"
        case group = "group"
        case id = "id"
        case ionEnergy = "ion_energy"
        case meltingC = "melting_c"
        case name = "name"
        case number = "number"
        case recordUrl = "record_url"
        case symbol = "symbol"
        case weight = "weight"
    }
}

struct PostElement: Codable {
    let name: String
    let favorite_element: String    
}
