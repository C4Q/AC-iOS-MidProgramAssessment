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
//
//    func addFavorite(completionHandler: @escaping ([Element]) -> Void,
//                     errorHandler: @escaping (Error) -> Void) {
//
//        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
//
//        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
//        let parseDataIntoFavoritesArr = {(data: Data) in
//            do {
//                let onlineOrders = try JSONDecoder().decode([Element].self, from: data)
//                completionHandler(onlineOrders)
//            }
//            catch let error {
//                errorHandler(AppError.codingError(rawError: error))
//            }
//        }
//        NetworkHelper.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoFavoritesArr, errorHandler: errorHandler)
//    }

    func add(favorite: Element, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
        do {
            let encodedFavorite = try JSONEncoder().encode(favorite)
            authPostRequest.httpBody = encodedFavorite
            NetworkHelper2.manager.performDataTask(with: authPostRequest, completionHandler: {_ in print("Added to favorites")}, errorHandler: errorHandler)
        }
        catch {
            errorHandler(AppError.codingError(rawError: error))
        }
    }
    private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: urlStr) else {return nil}
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

