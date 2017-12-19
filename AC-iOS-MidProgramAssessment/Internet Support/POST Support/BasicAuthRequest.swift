//
//  BasicAuthRequest.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

class BasicAuthRequest {
    private init() {}
    static let generate = BasicAuthRequest()
    
    //should return a request
    func buildAuthRequest(from urlStr: String, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = URL(string: urlStr) else {return nil}
        var request = URLRequest(url: url)
        
        //begin adding info to request
        let userName = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        
        let authStr = buildAuthString(userName: userName, password: password)
        
        //add authorization string to request header to get past basic auth
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        
        if httpMethod == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else if httpMethod == .GET {
            request.httpMethod = "GET"
        }
        //end adding info to request
        return request
    }
    
    //should build and return authStr for header injection
    private func buildAuthString(userName: String, password: String) -> String {
        //1. convert name and pass to right string format
        let nameAndPassStr = "\(userName):\(password)"
        
        //2. convert string to data (utf8)
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        
        //3. convert data to string (base-64)
        let base64AuthStr = nameAndPassData.base64EncodedString()
        
        //4. Add basic to the line and return it
        let authStr = "Basic \(base64AuthStr)"
        
        return authStr
    }
}
