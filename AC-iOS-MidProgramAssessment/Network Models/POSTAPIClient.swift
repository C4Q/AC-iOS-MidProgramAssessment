//
//  POSTAPIClient.swift
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
//
struct POSTAPIClient {
    private init() {}
    static let manager = POSTAPIClient()
    func getElementToPost(completionHandler: @escaping ([Element]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        //let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        //guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { return }
        let parseDataIntoOrderArr = {(data: Data) in
            do {
                let onlineElement = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(onlineElement)
            }
            catch let error {
                errorHandler(error)
            }
        }
        //NetworkHelper.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoOrderArr, errorHandler: errorHandler)
    }

enum AppError: Error {
    case badData
    case badURL
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
    case other(rawError: Error)
}

struct NetworkHelper2 {
    private init() {}
    static let manager = NetworkHelper2()
    private let session = URLSession(configuration: .default)
    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        session.dataTask(with: request){(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.badData); return}
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
}

    func post(Element:Element, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else { return }
        do {
            let encodedElement = try JSONEncoder().encode(Element)
            authPostRequest.httpBody = encodedElement
            NetworkHelper2.manager.performDataTask(with: authPostRequest,
                                                  completionHandler: {_ in print("Made a post request")},
                                                  errorHandler: errorHandler)
        }
        catch let error{
            errorHandler(error)
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

