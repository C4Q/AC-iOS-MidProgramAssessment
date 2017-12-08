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
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badURL)
            return
        }

        let request = URLRequest(url: url)

        NetworkHelper.manager.performDataTask(from: request,
                                              completionHandler: { (data) in
                //make sure you have an image
                guard let image = UIImage(data: data) else {
                    print("couldn't convert data to image")
                    return
                }
                completionHandler(image)
        },
            errorHandler: errorHandler)
    }
}

//class ImageAPIClient {
//    private init() {}
//    static let manager = ImageAPIClient()
//
//    func getImages(from keyWord: String,
//                   completionHandler: @escaping ([PeriodicElement]) -> Void,
//                   errorHandler: @escaping (Error) -> Void) {
//        //let apiKey = "7289848-451c3dc743d77a89fabd39354"
//        //let searchKeyword = keyWord.replacingOccurrences(of: " ", with: "+")
//        let urlString = "https://pixabay.com/api?key=\(apiKey)&q=\(searchKeyword)"
//
//        guard let url = URL(string: urlString) else {
//            errorHandler(AppError.badURL)
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        NetworkHelper.manager.performDataTask(
//            with: request,
//            completionHandler: { (data) in
//                do {
//                    let results = try JSONDecoder().decode([Element].self, from: data)
//                    let onlineImages = results.images
//
//                    completionHandler(onlineImages)
//
//                } catch let error {
//                    errorHandler(AppError.couldNotParseJSON(rawError: error))
//                }
//        },
//            errorHandler: errorHandler)
//    }
//}

//class ImageAPIClient{
//
//    private init(){}
//    static let manager = ImageAPIClient()
//
//    //parameters: urlStr, completionHandler and errorHandler
//    func loadImage(from urlStr: String,
//                   completionHandler: @escaping (UIImage) -> Void,
//                   errorHandler: @escaping (Error) -> Void) {
//
//        //make sure you can turn the the string into a url
//        guard let url = URL(string: urlStr) else {
//            errorHandler(AppError.badURL)
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        NetworkHelper.manager.performDataTask(with: request,
//                                            completionHandler: { (data) in
//                guard let image = UIImage(data: data) else {
//                    print("couldn't convert data to image")
//                    errorHandler(AppError.badURL)
//                    return
//                }
//
//                completionHandler(image)
//        },
//            errorHandler: errorHandler)
//    }
//}



