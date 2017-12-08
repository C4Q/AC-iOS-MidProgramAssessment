//
//  ImageAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//
import UIKit
import Foundation

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlStr: String,
                  completionHander: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(.notAnImage)
                return
            }
            completionHander(onlineImage)
        }
        ImageNetworkHelper.manager.performDataTask(with: url,
                                                   completionHandler: completion,
                                                   errorHandler: {print($0)})
    }
}
