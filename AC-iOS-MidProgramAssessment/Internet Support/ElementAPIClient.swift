//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
//add links to use

class ElementAPIClient {
    private init(){}
    static let manager = ElementAPIClient()
    
    //MARK: - Getting elements
    func getElements(from urlStr: String, completionHandler: @escaping ([PeriodicElement]) -> Void,
                     errorHandler: @escaping (Error) -> Void){
       
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        //guard let url = URL(string: urlStr) else {return}
        
        //if urlRequest is nil
        guard let basicAuthRequest = BasicAuthRequest.generate.buildAuthRequest(from: urlStr, httpMethod: .GET) else {errorHandler(AppError.badURL);return}
        
        //setting completion
        let parseDataIntoElementArr: (Data) -> Void = {(data: Data) in
            do{
                //Turning JSON -> Periodic Element Data
                let onlinePeriodicElements = try JSONDecoder().decode([PeriodicElement].self, from: data)
                
                //Turning Data -> [PeriodicElement]
                var periodicElementsFromOnline: [PeriodicElement] = []
                
                for periodicElement in onlinePeriodicElements{
                    periodicElementsFromOnline.append(periodicElement)
                    print("Building array of periodic elements!")
                }
                //call completionHandler
                completionHandler(onlinePeriodicElements)
                
            } catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        //Network Helper
        NetworkHelper.manager.performDataTask(from: basicAuthRequest,
                                              completionHandler: parseDataIntoElementArr,
                                              errorHandler: errorHandler)
    }

    //MARK: - Posting element as favorite
//    func POST(periodicElement: [PeriodicElement],
//              completionHandler: @escaping (Data) -> Void,
//              errorHandler: @escaping (Error) -> Void){
//        //where you are sending element to
//        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
//        //1. get auth request from url string
//        //make a request that uses POST http method
//        guard var authPostRequest = BasicAuthRequest.generate.buildAuthRequest(from: urlStr, httpMethod: .POST) else {
//            errorHandler(AppError.badURL)
//            return
//        }
//        //put the content of what you wanna post - using the httpBody instance property
//        do{
//            //2. encode foundation objection into json data (so api can use it), and then
//            
//            let encodedPeriodicElement = try JSONEncoder().encode(periodicElement)
//            //3. add that data to the http body of the authorized url request (the body is the message of the content)
//           
//            authPostRequest.httpBody = encodedPeriodicElement //should be data
//            //4. Now perform network request with url request, which has the data that you want to upload and the right authorizations
//            
//            NetworkHelper.manager.performDataTask(from: authPostRequest, completionHandler: completionHandler, errorHandler: errorHandler)
//            
//        }catch let error{
//            errorHandler(AppError.other(rawError: error))
//        }
//    }
}
