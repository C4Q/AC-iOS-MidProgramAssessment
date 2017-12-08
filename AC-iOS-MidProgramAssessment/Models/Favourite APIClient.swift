//
//  Favourite APIClient.swift
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

struct FavouriteAPIClient {
    private init() {}
    static let manager = FavouriteAPIClient()
    func getFavourites(completionHandler: @escaping ([Favourite]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
        let parseDataIntoFavouritesArr = {(data: Data) in
            do {
                let onlineFavourites = try JSONDecoder().decode([Favourite].self, from: data)
                completionHandler(onlineFavourites)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelperWithAuthentication.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoFavouritesArr, errorHandler: errorHandler)
    }
    //
    func post(favourite: Favourite, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        // the request has more bundles and options and can take more information
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
        do {
            // encode to match the JSON file
            let encodedOrder = try JSONEncoder().encode(favourite)
            authPostRequest.httpBody = encodedOrder
            NetworkHelperWithAuthentication.manager.performDataTask(with: authPostRequest,
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
