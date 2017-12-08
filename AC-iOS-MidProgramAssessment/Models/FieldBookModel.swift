//
//  FieldBookModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

import UIKit
struct FieldBook: Codable {
    let favorite_element: String? //Symbol of the favorite element
    let name: String? //Your name
}

struct FieldBookAPIClient {
    private init() {}
    static let manager = FieldBookAPIClient()
    
    func getFieldbookImagesArray(completionHander: @escaping ([FieldBook]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let urlString = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        
        guard let urlRequest = buildAuthRequest(from: urlString, httpVerb: .GET) else {
            errorHandler(.badURL)
            return
        }
        
        NetworkHelper.manager.performDataTask(
            with: urlRequest,
            completionHandler: { (data) in
                do {
                    let fieldbooks = try JSONDecoder().decode([FieldBook].self, from: data)
                    completionHander(fieldbooks)
                } catch let error {
                    errorHandler(.couldNotParseJSON(rawError: error))
                }
        },
            errorHandler: errorHandler)
        
    }
    
    func postImg(fieldbookpost: FieldBook, completionHandler: (FieldBook) -> Void, errorHandler: (Error) -> Void) {
        let endPoint = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authResponse = buildAuthRequest(from: endPoint, httpVerb: .POST) else {return}
        do {
            let encodedData = try JSONEncoder().encode(fieldbookpost)
            authResponse.httpBody = encodedData
            NetworkHelper.manager.performDataTask(with: authResponse, completionHandler: {print($0)}, errorHandler: {print($0)})
        }
        catch {
            errorHandler(AppError.codingError(rawError: error))
        }
    }
    private func buildAuthRequest(from url: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: url) else {return nil}
        var request = URLRequest(url: url)
        let userName = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        let nameAndPassStr = "\(userName):\(password)"
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        let authBase64Str = nameAndPassData.base64EncodedString()
        let authStr = "Basic \(authBase64Str)"
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        if httpVerb == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
        
    }
    
    
}
