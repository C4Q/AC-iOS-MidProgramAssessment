//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Ashlee Krammer on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct ElementAPIClient{
    private init() {}
    static let manager = ElementAPIClient()
    func getElements(from urlStr: String, completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (AppError) -> Void){


        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }

        let completion: (Data) -> Void = {(data: Data) in

            do{
                let myDecoder = JSONDecoder()

                let elements = try myDecoder.decode([Element].self, from: data)
                completionHandler(elements)

            } catch{
                print("Elements Table Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)

            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }






    enum HTTPVerb {
        case POST
        case GET
    }
}










//
//enum HTTPVerb: String {
//    case GET
//    case POST
//}
//
//class ElementAPIClient {
//    private init() {}
//    static let manager = ElementAPIClient()
//
//    func getElements(completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (Error) -> Void) {
//        let urlStr = "https://api.fieldbook.com/v1/5a21d3ea92dfac03005db55a/orders"
//        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else {
//            errorHandler(AppError.badURL); return}
//
//        let parseDataIntoElementArr = {(data: Data) in
//            do {
//                let onlineElements = try JSONDecoder().decode([Element].self, from: data)
//                completionHandler(onlineElements)
//            } catch {
//                errorHandler(AppError.codingError(rawError: error))
//            }
//        }
//        NetworkHelper.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoElementArr, errorHandler: errorHandler)
//
//    }
//
//
//
//    func post(element: Element, completionHandler: (Element) -> Void, errorHandler: @escaping (Error) -> Void ) {
//        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
//        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
//        do {
//            let encodedOrder = try JSONEncoder().encode(element)
//            authPostRequest.httpBody = encodedOrder
//            NetworkHelper.manager.performDataTask(with: authPostRequest, completionHandler: {print($0)}, errorHandler: errorHandler)
//
//        } catch {
//            errorHandler(AppError.codingError(rawError: error))
//        }
//
//
//
//
//    }
//
//
//    private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
//        guard let url = URL(string: urlStr) else { return nil }
//        var request = URLRequest(url: url)
//        let userName = "key-1"
//        let password = "p3Z-A83YixDsI-B4aRLm"
//        let authStr = buildAuthStr(userName: userName, password: password)
//        request.addValue(authStr, forHTTPHeaderField: "Authorization")
//
//        if httpVerb == .POST {
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        }
//        return request
//    }
//
//
//
//    private func buildAuthStr(userName: String, password: String) -> String {
//        let nameAndPassStr = "\(userName):\(password)"
//        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
//        let authBase64Str = nameAndPassData.base64EncodedString()
//        let authStr = "Basic \(authBase64Str)"
//        return authStr
//    }
//}
//






