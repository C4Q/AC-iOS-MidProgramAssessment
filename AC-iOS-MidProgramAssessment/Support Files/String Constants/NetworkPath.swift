//
//  NetworkPaths.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct NetworkPath {
    static let jsonGetAddress = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
    static let favoritePostAddress = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
    
    static let thumbnailAddressBase = "http://www.theodoregray.com/periodictable/Tiles/"
    // in between these two you put the 3 digit element number
    static let thumbnailAddressExtension = "/s7.JPG"
    
    static let fullsizeAddressBase = "http://images-of-elements.com/"
    // in between these two you put the lowercased element name
    static let fullsizeAddressExtension = ".jpg"
    
}
