//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
//add links to use

class NetworkHelper {
    
    private init(){}
    static let manager = NetworkHelper()
    
    private let urlSession = URLSession(configuration: .default)
    
    func performDataTask(from urlRequest: URLRequest,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void){
        
        urlSession.dataTask(with: urlRequest){(data, response, error) in
            
            DispatchQueue.main.async {
                //Make sure you have data
                guard let data = data else {errorHandler(AppError.noDataReceived); return}
                
                //make sure you have a response
                if let response = response as? HTTPURLResponse {
                    guard response.statusCode >= 200 && response.statusCode < 300 else {
                        errorHandler(AppError.badStatusCode(num: response.statusCode))
                        return
                    }
                }
                // Make sure to put back on main thread because data will change UI Elements
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
}

//use for post portion
//if let error = error {
//    let error = error as NSError
//    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
//        errorHandler(AppError.noInternetConnection)
//        return
//    } else {
//        errorHandler(AppError.other(rawError: error))
//        return
//    }
//}

