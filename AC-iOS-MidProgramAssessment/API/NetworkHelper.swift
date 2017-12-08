//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


//class NetworkHelper {
//
//    private init() {}
//    static let manager = NetworkHelper()
//    let urlSession = URLSession(configuration: .default)
//    func performDataTask(with request: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
//        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else {
//                    errorHandler(AppError.noDataReceived)
//                    return
//                }
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    errorHandler(AppError.badStatusCode)
//                    return
//                }
//                if let error = error {
//                    let error = error as NSError
//                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
//                        errorHandler(AppError.noInternetConnection)
//                        return
//                    }
//                    else {
//                        errorHandler(AppError.other(rawError: error))
//                    }
//                }
//                completionHandler(data)
//            }
//            }.resume()
//    }
//}

struct NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        session.dataTask(with: request){(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.badData); return}
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
}

