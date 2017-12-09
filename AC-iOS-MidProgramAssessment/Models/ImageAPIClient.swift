//
//  ImageAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = { (data: Data) in
            guard let onlineImage = UIImage(data: data) else { return }
            completionHandler(onlineImage)
        }
        let urlReq = URLRequest(url: url)
        NetworkHelper.manager.performDataTask(with: urlReq, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
