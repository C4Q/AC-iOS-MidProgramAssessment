//
//  ElementModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
//full size images
// http://images-of-elements.com/lowercasedElementName.jpg

//thumbnail images
//http://www.theodoregray.com/periodictable/Tiles/ElementNumberWithThreeDigits/s7.JPG


//CONFORM TO CODABLE!
//List EVERYTHING within coding keys!

struct PeriodicElement: Codable {
    
    var thumbNailImage: String {
        var threeDigitNumber = String(number)
        
        while threeDigitNumber.count < 3 {
            threeDigitNumber = "0" + threeDigitNumber
        }
        let newThumbNail = "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitNumber)/s7.JPG"
        return newThumbNail
    }
    
    var fullImage: String {
        let fullImage = "http://images-of-elements.com/\(name.lowercased()).jpg"
        return fullImage
    }
    
    var number: Int 
    let weight: Double
    let name: String
    let symbol: String
    let meltingPoint: Int?
    let boilingPoint: Int?
    //let discoveryYear: Int
    
    enum CodingKeys: String, CodingKey {
        case number
        case weight
        case name
        case symbol
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        //case discoveryYear = "discovery_year"
    }
}

