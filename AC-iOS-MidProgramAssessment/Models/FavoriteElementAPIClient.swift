//
//  FavoriteElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class FavoriteElementAPIClient {
    private init() {}
    static let manager = FavoriteElementAPIClient()
    let urlString = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
    func getFavoriteElements(completionHandler: @escaping ([FavoriteElement]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        
        guard let url = URL(string: urlString) else {
            errorHandler(.badURL(string: urlString))
            return
        }
        
        NetworkHelper.manager.performDataTask(
            with: url,
            completionHandler: { (data) in
                do {
                    let favoriteElements = try JSONDecoder().decode([FavoriteElement].self, from: data)
                    
                    completionHandler(favoriteElements)
                } catch let error {
                    errorHandler(.couldNotParseJSON(rawError: error))
                }
        },
            errorHandler: errorHandler)
    }
    
    func post(_ favoriteElement: FavoriteElement, completionHandler: @escaping (Data) -> Void,  errorHandler: @escaping (AppError) -> Void) {
        
        guard let url = URL(string: urlString) else {
            errorHandler(.badURL(string: urlString))
            return
        }
        
        let username = "key-1"
        let password = "ptJP0XOFIQ_xysF7nwoB"
        
        var request = BasicAuth.getURLRequest(from: url, username: username, password: password, httpMethod: .POST)
        
        
        do {
            //add data to request http body
            let encodedElement = try JSONEncoder().encode(favoriteElement)
            
            request.httpBody = encodedElement
            
            //finish adding data
            NetworkHelper.manager.performDataTask(with: request, completionHandler: completionHandler, errorHandler: errorHandler)
        } catch let error {
            errorHandler(.couldNotParseJSON(rawError: error))
        }
    }
}
