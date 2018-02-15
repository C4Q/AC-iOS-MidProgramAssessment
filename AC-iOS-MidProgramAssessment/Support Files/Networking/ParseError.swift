//
//  ParseError.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

enum ParseError: Error {
    case results(json: Any)
    case image(image: Any)
}
