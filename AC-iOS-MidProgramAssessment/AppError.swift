//
//  AppError.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case badImageData
    case badImageURL(string: String)
    case badStatusCode(num: Int)
    case badURL(string: String)
    case couldNotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
}
