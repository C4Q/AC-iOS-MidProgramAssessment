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
    let fullsizeURL: URL?
    
    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int?, boilingPoint: Int?, yearDiscovered: String) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
        self.yearDiscovered = yearDiscovered
        
        let digitsForURL = Element.addLeadingZeros(to: number)
        
        self.thumbnailURL = URL(string: "\(NetworkPath.thumbnailAddressBase)\(digitsForURL)\(NetworkPath.thumbnailAddressExtension)")
        self.fullsizeURL = URL(string: "\(NetworkPath.fullsizeAddressBase)\(name.lowercased())\(NetworkPath.fullsizeAddressExtension)")
    }
    
    private static func addLeadingZeros(to number: Int) -> String {
        var digits: String = ""
        
        if number/100 >= 1 {
            digits = String(number) 
        } else {
            if number/10 >= 1 {
                digits = "0" + String(number)
            } else if number/10 < 1 {
                digits = "00" + String(number)
            }
        }
        
        return digits
    } 
}
