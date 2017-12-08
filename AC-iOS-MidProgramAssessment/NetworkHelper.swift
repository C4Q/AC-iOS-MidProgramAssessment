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
    private let mySession = URLSession(configuration: .default)
    func performTask(from urlRequest: URLRequest,
                     completionHandler: @escaping (Data) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        mySession.dataTask(with: urlRequest) { (data, URLResponse, error) in
            DispatchQueue.main.async {
            guard let data = data else {return}
            if let error = error {
                errorHandler(error)
                return
            }
        completionHandler(data)
    }
        }.resume()
}
}
