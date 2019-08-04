//
//  ImageAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from imageUrlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) ->Void) {
        guard let url = URL(string: imageUrlStr) else { errorHandler(AppError.badURL); return }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(AppError.notAnImage)
                return
            }
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
    }
    
}
