//
//  ElementsAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Clint Mejia on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case GET
    case POST
}

struct ElementsAPIClient {
    private init() {}
    static let manager = ElementsAPIClient()
    func getElements(from: String, completionHandler: @escaping ([Elements]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
        let parseDataIntoOrderArr = {(data: Data) in
            do {
                let onlineElements = try JSONDecoder().decode([Elements].self, from: data)
                completionHandler(onlineElements)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoOrderArr, errorHandler: errorHandler)
    }
    func post(order: Elements, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
        do {
            let encodedFavoriteElements = try JSONEncoder().encode(order)
            authPostRequest.httpBody = encodedFavoriteElements
            NetworkHelper.manager.performDataTask(with: authPostRequest,
                                                  completionHandler: {_ in print("Made a post request")},
                                                  errorHandler: errorHandler)
        }
        catch {
            errorHandler(AppError.codingError(rawError: error))
        }
        
        
    }
    private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: urlStr) else { return nil }
        var request = URLRequest(url: url)
        let userName = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        let authStr = buildAuthStr(userName: userName, password: password)
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        if httpVerb == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    private func buildAuthStr(userName: String, password: String) -> String {
        let nameAndPassStr = "\(userName):\(password)"
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        let authBase64Str = nameAndPassData.base64EncodedString()
        let authStr = "Basic \(authBase64Str)"
        return authStr
    }
}
