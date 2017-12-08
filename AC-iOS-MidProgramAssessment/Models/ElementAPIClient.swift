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
    func getElements(from urlStr: String, completionHandler: @escaping (Element) -> Void, errorHandler: @escaping (AppError) -> Void){
        
        
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let elementsArr = try myDecoder.decode(Element.self, from: data)
                completionHandler(elementsArr)
                
            } catch{
                print("Elements Table Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
