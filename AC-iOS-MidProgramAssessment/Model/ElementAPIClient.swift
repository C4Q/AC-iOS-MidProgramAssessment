//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Lisa J on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElements(from urlStr: String, completionHandler: @escaping
        ([Element]) -> Void, errorHandler: @escaping (Error) -> Void) {
        //let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let element = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(element)
            } catch let error{
                
                errorHandler(error)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
