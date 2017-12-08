//
//  BasicAuthRequest.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class BasicAuth {
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    static func getURLRequest(from url: URL, username: String, password: String, httpMethod: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        
        //inject header
        
        let usernamePasswordString = "\(username):\(password)"
        let usernamePasswordData = usernamePasswordString.data(using: .utf8)!
        let base64AuthorizationString = usernamePasswordData.base64EncodedString()
        let basicAuthString = "Basic \(base64AuthorizationString)"
        
        request.addValue(basicAuthString, forHTTPHeaderField: "Authorization")
        
        if httpMethod == .GET {
            request.httpMethod = "GET"
        } else if httpMethod == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        //end of injection
        
        return request
    }
}
