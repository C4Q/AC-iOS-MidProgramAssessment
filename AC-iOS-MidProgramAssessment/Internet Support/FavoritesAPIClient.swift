//
//  FavoritesAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


enum HTTPVerb: String {
    case GET
    case POST
}

class FavoritesAPIClient {
    
    private init(){}
    static let manager = FavoritesAPIClient()
    
    //MARK: - Getting image and turning it into an [FavoriteImage]
        func getFavImages(from urlStr: String,
                          completionHander: @escaping ([Favorites]) -> Void,
                          errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        
//        guard let urlRequest = buildAuthRequest(from: urlString, httpVerb: .GET) else {
//            errorHandler(.badURL)
//            return
//        }
            
            guard let urlRequest = BasicAuthRequest.generate.buildAuthRequest(from: urlStr, httpMethod: .POST) else {
                errorHandler(AppError.badURL)
                return
            }
            
            let completion: (Data) -> Void = {(data) in
                do {
                    let favoriteImage = try JSONDecoder().decode([Favorites].self, from: data)
                    completionHander(favoriteImage)
                } catch let error {
                    errorHandler(AppError.couldNotParseJSON(rawError: error))
                }
            }
        
        NetworkHelper.manager.performDataTask(from: urlRequest,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }

//MARK: - Posting element as favorite
    func POST(fieldBook: Favorites,
              completionHandler: @escaping (Data) -> Void,
              errorHandler: @escaping (Error) -> Void){
        
        //0. where you are sending element to
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        
        //1. get auth request from url string
        //make a request that uses POST http method
        guard var authPostRequest = BasicAuthRequest.generate.buildAuthRequest(from: urlStr, httpMethod: .POST) else {
            errorHandler(AppError.badURL)
            return
        }
        
        //putting the content of what you wanna post - using the httpBody instance property
        do{
            //2. encode foundation objection into json data (so api can use it), and then
            let encodedFavoriteImage = try JSONEncoder().encode(fieldBook)
            
            //3. add that data to the http body of the authorized url request (the body is the message of the content)
            authPostRequest.httpBody = encodedFavoriteImage //should be data
            
            //4. Now perform network request with url request, which has the data that you want to upload and the right authorizations
            NetworkHelper.manager.performDataTask(from: authPostRequest, completionHandler: completionHandler, errorHandler: errorHandler)

        }catch let error{
            errorHandler(AppError.other(rawError: error))
        }
    }
}
