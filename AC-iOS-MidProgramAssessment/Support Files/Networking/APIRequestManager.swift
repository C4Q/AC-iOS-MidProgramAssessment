//
//  APIRequestManager.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class APIRequestManager {
    private init() {}
    
    static let shared = APIRequestManager()
    
    func getData(from url: URL, callback: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let errorFound = error {
                print("Error durring session: \(errorFound.localizedDescription)")
            }
            
            guard let validData = data else { return }
            
            callback(validData)
            }.resume()
    }
    
    func postRequest(to endPoint: String, data: [String : Any]) {
        guard let url = URL(string: endPoint) else { return }
        
        var request = URLRequest(url: url)        
        let namePassStr = "\(BasicAuth.username):\(BasicAuth.password)"
        let nameAndPassData = namePassStr.data(using: .utf8)!
        let base64AuthEncoding = nameAndPassData.base64EncodedString()
        let authStr = "Basic \(base64AuthEncoding)"
        
        request.httpMethod = "POST"
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        // request.addValue("application/json", forHTTPHeaderField: "Accept")
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = try JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = body
        } 
            
        catch {
            print("Error posting body: \(error.localizedDescription)")
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            if let foundError = error {
                print("Error encountered during post request: \(foundError.localizedDescription)")
            }
            
            if let gotResponse = response {
                let httpResponse = gotResponse as! HTTPURLResponse
                
                print("Response status code: \(httpResponse.statusCode)")
            }
            
            guard let validData = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: []) as? [String:Any]
                
                if let validJson = json { print(validJson) }
            }
                
            catch {
                print("Error converting json: \(error)")
            }
            }.resume()
    }
    
    func grabElements(from data: Data?) -> [Element]? {
        var elementsArr = [Element]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let response: [[String : AnyObject]] = jsonData as? [[String : AnyObject]] else {
                throw ParseError.results(json: jsonData)
            }
            
            for elementDict in response {
                if let element = Element(from: elementDict) { elementsArr.append(element) }
            }
        }
            
        catch let ParseError.results(json: json)  { print("Error encountered parsing key for object: \(json)") }
            
        catch { print("Unknown parsing error") }
        
        return elementsArr
    }
}
