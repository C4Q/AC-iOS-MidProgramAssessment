//  Element.swift
//  AC-iOS-MidProgramAssessment
//  Created by Winston Maragh on 12/8/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

struct Element: Codable {
	let id: Int //1,
	let number: Int //1,
	let weight: Double //1.0079,
	let name: String //"Hydrogen",
	let symbol: String //"H",
	let meltingPoint: Int?
	let boilingPoint : Int?
	var discoveryYearInt: Int?
	var discoveryYearString: String? //1776,
	enum CodingKeys: String, CodingKey {
		case id
		case number
		case weight
		case name
		case symbol
		case meltingPoint = "melting_c"
		case boilingPoint = "boiling_c"
		case discoveryYearInt = "discovery_year"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try values.decode(Int.self, forKey: .id )
		self.number = try values.decode(Int.self, forKey: .number)
		self.weight = try values.decode(Double.self, forKey: .weight)
		self.name = try values.decode(String.self, forKey: .name)
		self.symbol = try values.decode(String.self, forKey: .symbol)
		self.meltingPoint = try? values.decode(Int.self, forKey: .meltingPoint)
		self.boilingPoint = try? values.decode(Int.self, forKey: .boilingPoint)
		if let discoveryString = try? values.decode(String.self, forKey: .discoveryYearInt) {
			discoveryYearString = discoveryString
		} else if let discoveryInt = try? values.decode(Int.self, forKey: .discoveryYearInt) {
			discoveryYearInt = discoveryInt
		}
	}
}
