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
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let decoder = JSONDecoder()
                let elements = try decoder.decode([Element].self, from: data)
                completionHandler(elements)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
