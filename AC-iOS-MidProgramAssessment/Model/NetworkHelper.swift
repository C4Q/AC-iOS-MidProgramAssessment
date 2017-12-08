//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//  Created by Winston Maragh on 12/8/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation
import UIKit

//HTTP
enum HTTPVerb: String {
	case GET
	case POST
}

//AppError
enum AppError: Error {
	case badData
	case badURL
	case unauthenticated
	case codingError(rawError: Error)
	case invalidJSONResponse
	case couldNotParseJSON(rawError: Error)
	case noInternetConnection
	case badStatusCode
	case noDataReceived
	case notAnImage
	case other(rawError: Error)
}


//NetworkHelper - turns URL into Data
struct NetworkHelper {
	private init(){}
	static let manager = NetworkHelper()
	private let session = URLSession(configuration: .default)
	func performDataTask(withURL url: URL,
											 completionHandler: @escaping (Data)->Void,
											 errorHandler: @escaping (AppError)->Void){

		session.dataTask(with: url) {(data, response, error) in
			DispatchQueue.main.async {
				guard let data = data else {errorHandler(AppError.badData); return}
				if let error = error {
					errorHandler(AppError.other(rawError: error))
				}
				completionHandler(data)
			}
			}.resume()
	}
	func performDataTask(withURLRequest urlRequest: URLRequest,
											 completionHandler: @escaping (Data) -> Void,
											 errorHandler: @escaping (Error) -> Void) {
		session.dataTask(with: urlRequest){(data, response, error) in
			DispatchQueue.main.async {
				guard let data = data else {errorHandler(AppError.badData); return}
				if let error = error {
					errorHandler(AppError.other(rawError: error))
				}
				completionHandler(data)
			}
			}.resume()
	}
}

class ImageAPIClient {
	private init() {}
	static let manager = ImageAPIClient()

	func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {
		guard let url = URL(string: urlStr) else { errorHandler(AppError.badURL); return}
		let completion: (Data) -> Void = {(data: Data) in
			guard let onlineImage = UIImage(data: data) else {return}
			completionHandler(onlineImage) //call completionHandler
		}
		NetworkHelper.manager.performDataTask(withURL: url, completionHandler: completion, errorHandler: errorHandler)
	}
	
}
