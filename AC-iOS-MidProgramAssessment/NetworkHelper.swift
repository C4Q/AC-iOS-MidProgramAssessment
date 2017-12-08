//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: .default)
    func getData(from urlRequest: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (AppError) -> Void) {
        urlSession.dataTask(
        with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode < 200, response.statusCode > 300 {
                    errorHandler(AppError.badStatusCode(num: response.statusCode))
                    return
                }
                
                if let data = data {
                    completionHandler(data)
                }
            }
        }.resume()
    }
    
    func getData(from url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (AppError) -> Void) {
        urlSession.dataTask(
        with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode < 200, response.statusCode > 300 {
                    errorHandler(AppError.badStatusCode(num: response.statusCode))
                    return
                }
                
                if let data = data {
                    completionHandler(data)
                }
            }
            }.resume()
    }
}
