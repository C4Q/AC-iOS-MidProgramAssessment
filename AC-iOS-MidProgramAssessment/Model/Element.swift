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
	let meltingPoint: Int? //-259,
	let boilingPoint : Int?// -253,
	let discoveryYear: Int? //1776,
	enum CodingKeys: String, CodingKey {
		case id
		case number
		case weight
		case name
		case symbol
		case meltingPoint = "melting_c"
		case boilingPoint = "boiling_c"
		case discoveryYear = "discovery_year"
	}
}

