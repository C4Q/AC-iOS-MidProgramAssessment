//
//  FavoritesModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Favorites {
    let name: String
    let favoriteElement: String
    
    enum CodingKeys: String, CodingKey {
        case favoriteElement = "favorite_element"
    }
}
