//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Element: Codable {
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
    //    let discovery_year: Int? //// Coding Keys?
}


class PeriodicTableAPIClient {
    private init() {}
    static let manager = PeriodicTableAPIClient()
    func getElements(from url: String, completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (Error) -> Void ) {
        guard let url = URL(string: url) else { errorHandler(AppError.badURL) ; return }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let onlinePT = try JSONDecoder().decode([Element].self, from: data) //if error getting data, check here
                let onlineElements = onlinePT
                completionHandler(onlineElements)
            }
            catch {
                errorHandler(AppError.badData)
            }
        }
        URLRequestNetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}


//For Posting Element to fieldBook

enum HTTPVerb: String {
    case POST
}

struct PostFavElement: Codable {
    let name: String
    let favorite_element: String
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

struct PostFavoriteElementAPI {
    private init() {}
    static let manager = PostFavoriteElementAPI()
    func postFavElement(element: PostFavElement, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {print("Error posting: \(Error.self)"); return }
        
        do {
            let encodedOrder = try JSONEncoder().encode(element)
            authPostRequest.httpBody = encodedOrder
            URLRequestNetworkHelper.manager.performDataTask(with: authPostRequest,
                                                            completionHandler: {_ in print("Made a post request!")},
                                                            errorHandler: errorHandler)
        }
        catch {
            errorHandler(error)
        }
    }
}



//Created two API clients due to testing a problem I was having with getting bad data. Probably could just use only the URL Request Network Helper but did not have time to refactor.

//class PeriodicTableAPIClientTest {
//    private init() {}
//    static let manager = PeriodicTableAPIClientTest()
//    func getElements(from urlStr: String, completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (Error) -> Void ) {
//        guard let url = URL(string: urlStr) else { errorHandler(AppError.badURL) ; return }
//        let completion: (Data) -> Void = { (data: Data) in
//            do {
//                let onlinePT = try JSONDecoder().decode([Element].self, from: data) //if error getting data, check here
//                let onlineElements = onlinePT
//                completionHandler(onlineElements)
//            }
//            catch {
//                errorHandler(AppError.badData)
//            }
//        }
//        RegularNetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
//    }
//
//}



