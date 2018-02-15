//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class Element {    
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let meltingPoint: Int?
    let boilingPoint: Int?
    // this could be a number or text, so let's make it easier on ourselves by storing any numbers we get as Strings 
    let yearDiscovered: String 
    let thumbnailURL: URL?
    let portraitURL: URL?
    
    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int?, boilingPoint: Int?, yearDiscovered: String, thumbnailURL: URL?, portraitURL: URL?) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
        self.yearDiscovered = yearDiscovered
        self.thumbnailURL = thumbnailURL
        self.portraitURL = portraitURL
    }
    
    convenience init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int?, boilingPoint: Int?, yearDiscovered: String, thumbnailAddress: String, portraitAddress: String) {
       
        let thumbnailURL = URL(string: thumbnailAddress) ?? nil
        let portraitURL = URL(string: portraitAddress) ?? nil
        
        self.init(name: name, symbol: symbol, number: number, weight: weight, meltingPoint: meltingPoint, boilingPoint: boilingPoint, yearDiscovered: yearDiscovered, thumbnailURL: thumbnailURL, portraitURL: portraitURL)
    }
}
