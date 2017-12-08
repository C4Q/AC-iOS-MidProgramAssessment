//
//  FavoriteAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case GET
    case POST
}

struct FavoriteAPIClient {
    private init() {}
    static let manager = FavoriteAPIClient()
    
    func getMyFavorites(completionHandler: @escaping ([Favorite]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites?name=Diego"
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badUrl); return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineOrders = try JSONDecoder().decode([Favorite].self, from: data)
                completionHandler(onlineOrders)
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    func post(favorite: Favorite, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {
            errorHandler(AppError.badUrl); return
        }
        do {
            let encodedOrder = try JSONEncoder().encode(favorite)
            authPostRequest.httpBody = encodedOrder
            NetworkHelper.manager.performTask(with: authPostRequest, completionHandler: {print("success: \($0)")}, errorHandler: errorHandler)
        } catch {
            errorHandler(AppError.codingError(rawError: error))
        }
    }
    
    //MARK: - BUILDING URL REQUESTS
    private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: urlStr) else {return nil}
        var request = URLRequest(url: url)
        request.addValue(buildAuthStr(userName: "key-1", password: "ptJP0XOFIQ_xysF7nwoB"), forHTTPHeaderField: "Authorization")
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
