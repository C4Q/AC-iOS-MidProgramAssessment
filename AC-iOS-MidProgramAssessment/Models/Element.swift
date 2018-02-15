//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class Element {    
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let meltingPoint: Int?
    let boilingPoint: Int?
    // this could be a number or text, so let's make it easier on ourselves by storing any numbers we get as Strings 
    var yearDiscovered: String? 
    let thumbnailURL: URL?
    let fullsizeURL: URL?
    var thumbnailPic: UIImage?
    var fullsizePic: UIImage?
    
    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int?, boilingPoint: Int?, yearDiscovered: String) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
        self.yearDiscovered = yearDiscovered
                
        let urls = Element.buildPicURLs(fromNumber: number, andName: name)
        
        self.thumbnailURL = urls.thumbnail
        self.fullsizeURL = urls.fullsize
        
        self.fullsizePic = nil
        self.thumbnailPic = nil
    }
    
    // MARK: - Networking Niceties
    
    init?(from elementDict: [String:AnyObject]) {
        guard let nameFromDict = elementDict["name"] as? String,
              let numberFromDict = elementDict["number"] as? Int,
              let symbolFromDict = elementDict["symbol"] as? String,
              let weightFromDict = elementDict["weight"] as? Double,
              let meltingPointFromDict = elementDict["melting_c"] as? Int,
              let boilingPointFromDict = elementDict["boiling_c"] as? Int?
        else { return nil }
        
        self.name = nameFromDict
        self.number = numberFromDict
        self.symbol = symbolFromDict
        self.weight = weightFromDict
        
        // This one is either a string or an int
        
        if let discoveredFromDict = elementDict["discovery_year"] as? String {
            self.yearDiscovered = discoveredFromDict
        } else {
            if let discoveredFromDict = elementDict["discovery_year"] as? Int {
                self.yearDiscovered = String(describing: discoveredFromDict)
            }
        }
        
        self.meltingPoint = meltingPointFromDict
        self.boilingPoint = boilingPointFromDict
        
        let urls = Element.buildPicURLs(fromNumber: number, andName: name)
        
        self.thumbnailURL = urls.thumbnail
        self.fullsizeURL = urls.fullsize
        
        self.thumbnailPic = nil
        self.fullsizePic = nil
    }
    
    // MARK: - Image URL helpers
    
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
    
    private static func buildPicURLs(fromNumber number: Int, andName name: String) -> (thumbnail: URL?, fullsize: URL?) {
        let digitsForURL = Element.addLeadingZeros(to: number)
        
        let thumbnailURL = URL(string: "\(NetworkPath.thumbnailAddressBase)\(digitsForURL)\(NetworkPath.thumbnailAddressExtension)")
        let fullsizeURL = URL(string: "\(NetworkPath.fullsizeAddressBase)\(name.lowercased())\(NetworkPath.fullsizeAddressExtension)")
        
        return (thumbnailURL, fullsizeURL)
    }
}
