//
//  PostNetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Caroline Cruz on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case badURL
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
    case other(rawError: Error)
}

struct PostNetworkHelper {
    private init() {}
    static let manager = PostNetworkHelper()
    private let session = URLSession(configuration: .default)
    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        self.session.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.badData)
                    return
                }
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        errorHandler(AppError.badStatusCode(num: response.statusCode))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
