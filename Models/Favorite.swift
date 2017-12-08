//
//  Favorite.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let name: String
    let favoriteElement: String
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteElement = "favorite_element"
    }
}
