//
//  File.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct Favorite: Codable {
    let name: String?
    let favorite_element: String?
}
class ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElement(from urlStr: String,
                    completionHandler: @escaping ([Element]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        guard let myUrl = URL(string: urlStr) else {return}
        let urlRequest = URLRequest(url: myUrl)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let elementArr = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(elementArr)
            } catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performTask(from: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    func post(favorate: Favorite, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr) else {return}
        do {
        let encoder = try JSONEncoder().encode(favorate)
            authPostRequest.httpBody = encoder
             NetworkHelper.manager.performTask(from: authPostRequest, completionHandler: {_ in print("Made a post request")}, errorHandler: errorHandler)
        } catch {
            errorHandler(error)
        }
    }
    private func buildAuthRequest(from urlStr: String) -> URLRequest? {
        guard let url = URL(string: urlStr) else {return nil}
        let userName = "key-1"
        let passWord = "ptJP0XOFIQ_xysF7nwoB"
        var request = URLRequest(url: url)
        let authStr = builAuthStr(username: userName, password: passWord)
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
   private func builAuthStr(username: String, password: String) -> String {
    let nameAndPasswordStr = "\(username):\(password)"
    let nameAndPasswordData = nameAndPasswordStr.data(using: .utf8)!
    let authBase64Str = nameAndPasswordData.base64EncodedString()
    let authStr = "Basic \(authBase64Str)"
    return authStr
    }
}

class ElementImageAPIClient {
    private init() {}
    static let manager = ElementImageAPIClient()
    func getImages(from imageStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let imageUrl = URL(string: imageStr) else {return}
        let urlRequest = URLRequest(url: imageUrl)
        let completion: (Data) -> Void = {(data: Data) in
            if let onlineImage = UIImage(data: data) {
                completionHandler(onlineImage)
            } 
        }
        NetworkHelper.manager.performTask(from: urlRequest, completionHandler: completion, errorHandler: errorHandler)
        
    }
}


