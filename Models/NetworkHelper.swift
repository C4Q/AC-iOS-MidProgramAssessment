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
    case badUrl
    case failedToGetImage
    case codingError(rawError: Error)
    case other(rawError: Error)
}


struct NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    func performTask(with url: URLRequest,
                     completionHandler: @escaping (Data) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        self.session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.badData); return
                }
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
    
    func performTask(with url: URL,
                     completionHandler: @escaping (Data) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        self.session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.badData); return
                }
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
}
