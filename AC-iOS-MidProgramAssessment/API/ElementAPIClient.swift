//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


//struct ElementAPIClient {
//    private init() {}
//    static let manager = ElementAPIClient()
//    func getElement(from urlStr: String, completionHandler: @escaping ([ElementInfo]) -> Void, errorHandler: @escaping (AppError) ->Void) {
//        guard let url = URL(string: urlStr) else { return }
//        let completion: (Data) -> Void = {(data: Data) in
//            do {
//                let elements = try JSONDecoder().decode([ElementInfo].self, from: data)
//                completionHandler(elements)
//            } catch {
//                errorHandler(.couldNotParseJSON(rawError: error))
//            }
//        }
//        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
//    }
//
//}

struct ElementPost: Codable{
    let name: String
    let favorite_element: String
}

enum HTTPVerb: String {
    case GET
    case POST
}

struct ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElement(from urlStr: String, completionHandler: @escaping ([ElementInfo]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
        let parseDataIntoFavArr = {(data: Data) in
            do {
                let elements = try JSONDecoder().decode([ElementInfo].self, from: data)
                completionHandler(elements)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoFavArr, errorHandler: errorHandler)
    }
    func postFavorite(favElement: ElementPost, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
        do {
            let encodedOrder = try JSONEncoder().encode(favElement)
            authPostRequest.httpBody = encodedOrder
            NetworkHelper.manager.performDataTask(with: authPostRequest,
                                                  completionHandler: {_ in print("Successfully made post request")},
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
