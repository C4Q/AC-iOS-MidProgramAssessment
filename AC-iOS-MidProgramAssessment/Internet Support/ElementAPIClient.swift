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
}
