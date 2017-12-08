//
//  NetWorkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case GET
    case POST
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: .default)
    
    func performDataTask(with url: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
        
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                if let response = response as? HTTPURLResponse {
                    errorHandler(AppError.badStatusCode(num: response.statusCode))
                    //print(response.statusCode)
                    //return
                }
                
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        errorHandler(AppError.noInternetConnection)
                        return
                    }
                    else {
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
