//
//  ImageAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

///CONFORM TO IMPORT UIKIT

class ImageAPIClient {

    private init() {}
    static let manager = ImageAPIClient()

    func getImage(from urlString: String,
                  completionHandler: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (Error) -> Void) {

        //make sure you have a url
        guard let url = URL(string: urlString) else {errorHandler(AppError.badURL); return}
        
        //New! -> making a URL request
        let request = URLRequest(url: url)
        
        let completion = {(data: Data) in
            //make sure you can get an online image from the data
            guard let onlineImage = UIImage(data: data) else {print("couldn't convert data to image");  return}
            completionHandler(onlineImage)
        }
        //call NetworkHelper
        NetworkHelper.manager.performDataTask(from: request,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

