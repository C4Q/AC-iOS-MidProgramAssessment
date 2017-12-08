//
//  AppError.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case goodStatusCode(num: Int)
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
    case badData
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
}
