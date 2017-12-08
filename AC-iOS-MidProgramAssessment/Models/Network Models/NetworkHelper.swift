//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

import Foundation

enum AppError: Error {
    case badData
    case badURL
    case codingError(rawError: Error)
    case badStatusCode(_: Int)
    case other(rawError: Error)
}

enum HTTPVerb {
    case get
    case post
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.badData)
                    return
                }
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 && response.statusCode != 201 {
                        errorHandler(AppError.badStatusCode(response.statusCode))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
