//
//  NetworkHelper1.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                
                if let varResponse = response as? HTTPURLResponse {
                    if varResponse.statusCode != 200 {
                        print(data)
                        errorHandler(AppError.badStatusCode1)
                        print(varResponse.statusCode)
                        return
                    }
                }
               
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        errorHandler(AppError.noInternetConnection)
                        return
                    } else {
                        errorHandler(AppError.other(rawError: error))
                        return
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
