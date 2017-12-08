//
//  ElementsAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Maryann Yin on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ElementsAPIClient {
    private init() {}

    static let manager = ElementsAPIClient()

    func getTVEpisodes (from urlStr: String,
                        completionHandler: @escaping ([ElementWrapper]) -> Void,
                        errorHandler: @escaping (Error) -> Void){
        guard let url = URL(string: urlStr) else {return}
        
        let completion: (Data) -> Void = {(data: Data) in
            do{
                let decoder = JSONDecoder()
                let elementsFromTheInternet = try decoder.decode([ElementWrapper].self, from: data)
                completionHandler(elementsFromTheInternet)
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
    
}
