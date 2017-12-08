//
//  NetworkHelper2.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class NetworkHelper2 {
    private init() {}
    static let manager = NetworkHelper2()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest,
        completionHandler: @escaping (Data) -> Void,
        errorHandler: @escaping (AppError) -> Void) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                if let error = error {
                    errorHandler(error as! AppError)
                }
                completionHandler(data)
            }
            }.resume()
    }
}
