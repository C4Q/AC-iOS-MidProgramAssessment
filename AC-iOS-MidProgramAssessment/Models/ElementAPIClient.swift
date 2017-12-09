//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ElementAPIClient {
    
    private init() {}
    static let manager = ElementAPIClient()
    
    func getElements(from urlStr: String, completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        let completion = {(data: Data) -> Void in
            do {
                let onlineElements = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(onlineElements)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
