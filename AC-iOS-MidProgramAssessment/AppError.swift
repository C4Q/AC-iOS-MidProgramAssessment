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
    case badImageURL
    case badStatusCode(num: Int)
    case badURL
    case couldNotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
}
