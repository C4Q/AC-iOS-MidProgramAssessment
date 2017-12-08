//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElements(completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let urlString = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badURL(string: urlString))
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data) in
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    
                    completionHandler(elements)
                } catch let error {
                    errorHandler(AppError.couldNotParseJSON(rawError: error))
                }
        },
            errorHandler: errorHandler)
    }
}
