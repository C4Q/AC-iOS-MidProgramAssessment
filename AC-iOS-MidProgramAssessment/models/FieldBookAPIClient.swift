//
//  FieldBookAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct FieldBookAPIClient {
    private init() {}
    static let manager = FieldBookAPIClient()
    
    func post(fieldbookpost: FieldBook, completionHandler: (FieldBook) -> Void, errorHandler:  (AppError) -> Void) {
        let endPoint = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authResponse = buildAuthRequest(from: endPoint) else {return}
        do {
            let encodedData = try JSONEncoder().encode(fieldbookpost)
            authResponse.httpBody = encodedData
            NetworkHelper.manager.performDataTask(with: authResponse, completionHandler: {print($0)}, errorHandler: {print($0)})
        }
        catch {
             errorHandler(AppError.codingError(rawError: error))
        }
    }
    
    
    
    private func buildAuthRequest(from url: String) -> URLRequest? {
        guard let url = URL(string: url) else {return nil}
        var request = URLRequest(url: url)
        let userName = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        let nameAndPassStr = "\(userName):\(password)"
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        let authBase64Str = nameAndPassData.base64EncodedString()
        let authStr = "Basic \(authBase64Str)"
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
