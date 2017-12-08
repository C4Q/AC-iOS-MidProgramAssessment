//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case other(rawError: Error)
    case badURL
    case badStatusCode(num: Int)
}


class URLRequestNetworkHelper {
    private init() {}
    static let manager = URLRequestNetworkHelper()
    private let session = URLSession(configuration: .default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        session.dataTask(with: request){(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.badData); return}
                if let response = response as? HTTPURLResponse {
                    print(response)
                }
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                
                completionHandler(data)
            }
            
            }.resume()
    }
}


class RegularNetworkHelper {
    private init() {}
    static let manager = RegularNetworkHelper()
    private let mySession = URLSession(configuration: .default)
    func performDataTask(with url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        mySession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(error)
                    return
                }
                completionHandler(data)
            }
            }
            .resume()
    }
}
