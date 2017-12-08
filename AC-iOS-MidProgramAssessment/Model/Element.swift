//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Lisa J on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Element: Codable {
    let id: Int
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
    let discovery_year: Int
}
struct FaveElement: Codable {
    let name: String
    let favorite_element:String
}
enum HTTPVerb: String {
    case GET
    case POST
}

struct ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElements(completionHandler: @escaping
        ([Element]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET ) else {errorHandler(AppError.badURL); return}
        let parseDataIntoElementArr = {(data: Data) in
            do {
                let onlineElements = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(onlineElements)
            } catch let error{
                
                errorHandler(AppError.codingError(rawError: error))
                
            }
        }
        NetworkHelper.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoElementArr, errorHandler: errorHandler)
    }
    func post(element: FaveElement, errorHandler: @escaping (Error)-> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return}
        do {
            let encodedElement = try JSONEncoder().encode(element)
            authPostRequest.httpBody = encodedElement
            NetworkHelper.manager.performDataTask(with: authPostRequest, completionHandler: {_ in print("Made a post request")}, errorHandler: errorHandler)
        } catch {
            errorHandler(AppError.codingError(rawError: error))
            
        }
    }
    private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: urlStr) else {return nil}
        var request = URLRequest(url:url)
        let userName = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        let authStr = buildAuthStr(userName: userName, password: password)
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        if httpVerb == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            //tells API to expect to get json
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    private func buildAuthStr(userName: String, password: String) ->
        String{
            let nameAndPassStr = "\(userName):\(password)"
            let nameAndPassData = nameAndPassStr.data(using: .utf8)!
            let authBase64Str = nameAndPassData.base64EncodedString()
            let authStr = "Basic \(authBase64Str)"// str that will be in the header
            return authStr
    }
}

