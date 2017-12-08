//
//  Favourite Model.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct Favourite: Codable {
    let name: String?
    let favoriteElement: String?
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteElement = "favorite_element"
    }
    init(name: String, favouriteElement: String) {
        self.name =  name
        self.favoriteElement = favouriteElement
    }
}
