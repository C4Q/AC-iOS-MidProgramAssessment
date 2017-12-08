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
    func getData(from urlRequest: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        urlSession.dataTask(
        with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
             
                
            }
        }.resume()
    }
}
