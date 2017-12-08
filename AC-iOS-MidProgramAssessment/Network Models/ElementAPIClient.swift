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
    func getElements(from urlStr: String,
                  completionHandler: @escaping ([Element]) -> Void, //LOOK AT...
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        //Convert data to Shows
        let completion: (Data) -> Void = {(data: Data) in
            do {
                //The below is telling the network helper what to do when it gets data
                let elementData = try JSONDecoder().decode([Element].self,from:data)
                completionHandler(elementData)
            }
            catch let error {
                errorHandler(error)
            }
        }

        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,                                              errorHandler: errorHandler)
    }
}

