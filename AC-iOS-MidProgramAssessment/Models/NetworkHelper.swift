//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)
    case notAnImage
}
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    //Data error handling
                    errorHandler(AppError.noDataReceived)
                    return
                }
                //check for the error 200
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    errorHandler(AppError.badStatusCode)
                    return
                }
                if let error = error {
                    let error = error as NSError
                    //check for no internet connection
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler(AppError.noInternetConnection)
                    }else{
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
