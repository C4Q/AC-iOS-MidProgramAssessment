//
//  AppError.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Clint Mejia on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case codingError(rawError: Error)
    case badURL
    case badData
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}

