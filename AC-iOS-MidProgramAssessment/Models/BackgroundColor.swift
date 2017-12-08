//
//  BackgroundColor.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class BackgroundColor {
    
    //for background color of the element
    private static let colorDict: [String: (red: CGFloat, green: CGFloat, blue: CGFloat)] = [
        "alkaliMetal": (159/255, 234/255, 159/255), //Group 1 - after nonmetal and metalloids are checked for
        "alkalineEarthMetal": (247/255, 193/255, 101/255), //Group 2
        "transitionMetal": (155/255, 244/255, 240/255), //Group 3-12
        "otherMetal": (221/255, 144/255, 217/255), //Groups 13-16
        "nonmetal": (187/255, 236/255, 237/255), //make sure to have a special if case to check if symbols are hcnops and se
        "metalloids": (251/255, 194/255, 204/255), //B, Si, Ge, As, Sb, Te, Po
        "halogen": (193/255, 193/255, 247/255), //Group 17
        "nobleGas": (92/255, 119/255, 168/255), // Group 18
        "otherMetals": (117/255, 185/255, 212/255) //everything else
    ]
    
    private static let inverseColorDict: [String: (red: CGFloat, green: CGFloat, blue: CGFloat)] = [
        "alkaliMetal": (1 - 159/255, 1 - 234/255, 1 - 159/255), //Group 1 - after nonmetal and metalloids are checked for
        "alkalineEarthMetal": (1 - 247/255, 1 - 193/255, 1 - 101/255), //Group 2
        "transitionMetal": (1 - 155/255, 1 - 244/255, 1 - 240/255), //Group 3-12
        "otherMetal": (1 - 221/255, 1 - 144/255, 1 - 217/255), //Groups 13-16
        "nonmetal": (1 - 187/255, 1 - 236/255, 1 - 237/255), //make sure to have a special if case to check if symbols are hcnops and se
        "metalloids": (1 - 251/255, 1 - 194/255, 1 - 204/255), //B, Si, Ge, As, Sb, Te, Po
        "halogen": (1 - 193/255, 1 - 193/255, 1 - 247/255), //Group 17
        "nobleGas": (1 - 92/255, 1 - 119/255, 1 - 168/255), // Group 18
        "otherMetals": (1 - 117/255, 1 - 185/255, 1 - 212/255) //everything else
    ]
    
    //gets color for background
    static func forElement(group: Int, symbol: String) -> (CGFloat, CGFloat, CGFloat)? {
        switch (group, symbol) {
        case (_, "H"), (_, "C"), (_, "N"), (_, "O"), (_, "P"), (_, "S"), (_, "Se"):
            return colorDict["nonmetal"]
        case (_, "B"), (_, "Si"), (_, "Ge"), (_, "As"), (_, "Sb"), (_, "Te"), (_, "Po"):
            return colorDict["metalloids"]
        case (1, _):
            return colorDict["alkaliMetal"]
        case (2, _):
            return colorDict["alkalineEarthMetal"]
        case (3...12, _):
            return colorDict["transitionMetal"]
        case (13...16, _):
            return colorDict["otherMetal"]
        case (17, _):
            return colorDict["halogen"]
        case (18, _):
            return colorDict["nobleGas"]
        default:
            return colorDict["otherMetal"]
        }
    }
    
    //gets reversed colors for text
    static func inverseForElement(group: Int, symbol: String) -> (CGFloat, CGFloat, CGFloat)? {
        switch (group, symbol) {
        case (_, "H"), (_, "C"), (_, "N"), (_, "O"), (_, "P"), (_, "S"), (_, "Se"):
            return inverseColorDict["nonmetal"]
        case (_, "B"), (_, "Si"), (_, "Ge"), (_, "As"), (_, "Sb"), (_, "Te"), (_, "Po"):
            return inverseColorDict["metalloids"]
        case (1, _):
            return inverseColorDict["alkaliMetal"]
        case (2, _):
            return inverseColorDict["alkalineEarthMetal"]
        case (3...12, _):
            return inverseColorDict["transitionMetal"]
        case (13...16, _):
            return inverseColorDict["otherMetal"]
        case (17, _):
            return inverseColorDict["halogen"]
        case (18, _):
            return inverseColorDict["nobleGas"]
        default:
            return inverseColorDict["otherMetal"]
        }
    }
}
