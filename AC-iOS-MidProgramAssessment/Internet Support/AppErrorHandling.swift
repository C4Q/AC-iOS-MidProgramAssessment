//
//  AppErrorHandling.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case noInternetConnection
    case badURL
    case noDataReceived
    case noImage
    case couldNotParseJSON(rawError: Error)
    case other(rawError: Error)
    case badStatusCode(num: Int)
}
