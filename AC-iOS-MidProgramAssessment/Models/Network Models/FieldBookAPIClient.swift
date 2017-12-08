//
//  FieldBookAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct FieldBookAPIClient {
    
    private init() {}
    static let manager = FieldBookAPIClient()
    
    func getElements(completionHandler: @escaping ([Element]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let str = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        guard let url = URL(string: str) else {
            errorHandler(AppError.badURL)
            return
        }
        let getReq = URLRequest(url: url)
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let classImgs = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(classImgs)
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: getReq, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    func postFavElement(favElement: FavElement,
                    completionHandler: (FavElement) -> Void,
                    errorHandler: (Error) -> Void) {
        let endpoint = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authResponse = buildAuthRequest(from: endpoint, httpVerb: .post) else {
            errorHandler(AppError.badURL)
            return
        }
        do {
            let encodedData = try JSONEncoder().encode(favElement)
            authResponse.httpBody = encodedData
            NetworkHelper.manager.performDataTask(with: authResponse, completionHandler: { print($0) }, errorHandler: { print($0) })
        } catch {
            errorHandler(AppError.codingError(rawError: error))
        }
    }
    
    private func buildAuthRequest(from url: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        let userName = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        let nameAndPassStr = "\(userName):\(password)"
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        let authBase64Str = nameAndPassData.base64EncodedString()
        let authStr = "Basic \(authBase64Str)"
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        if httpVerb == .post {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
}
