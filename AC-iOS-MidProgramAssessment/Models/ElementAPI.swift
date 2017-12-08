//
//  ElementAPI.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Caroline Cruz on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ElementAPI {
    private init() {}
    static let manager = ElementAPI()
    func getElement(from urlStr: String,
                    completionHandler: @escaping ([Element]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let element = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(element)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
