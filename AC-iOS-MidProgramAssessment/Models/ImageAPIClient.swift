//
//  ImageAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImages(from urlString: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badImageURL(string: urlString))
            return
        }
        
        NetworkHelper.manager.performDataTask(
            with: url,
            completionHandler: { (data) in
                guard let image = UIImage(data: data) else {
                    errorHandler(AppError.badImageData)
                    return
                }
                
                completionHandler(image)
        },
            errorHandler: errorHandler)
    }
}
