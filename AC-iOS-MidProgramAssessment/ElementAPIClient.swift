//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class ElementAPICLient {
    private init() {}
    static let manager = ElementAPICLient()
    func getElement(completionHandler: @escaping ([Element]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        guard let url = URL(string: urlStr) else {return}
        let request = URLRequest(url:url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let allElements = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(allElements)
            }
            catch let error {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
}
