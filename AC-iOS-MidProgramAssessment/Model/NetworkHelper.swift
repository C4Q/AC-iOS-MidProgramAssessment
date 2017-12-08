//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//  Created by Winston Maragh on 12/8/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

//APPError
enum AppError: Error {
	case badData
	case badURL
	case unauthenticated
	case codingError(rawError: Error)
	case invalidJSONResponse
	case JSONDecodeError(decodeError: Error)
	case JSONEncodeError(encodeError: Error)
	case noInternetConnection
	case badStatusCode
	case noDataReceived
	case notAnImage
	case other(rawError: Error)
}


//NetworkHelper - turns URL into Data
struct NetworkHelper {
	//Singleton
	private init(){}
	static let manager = NetworkHelper()
	//Create Session
	//private let session = URLSession(configuration: .default)
	//Method to get Data
	func performDataTask(with url: URL, completionHandler: @escaping (Data)->Void, errorHandler: @escaping (AppError)->Void){
		//		let task = session.dataTask(with: url) {(data, response, error) in
		let task = URLSession(configuration: .default).dataTask(with: url) {(data, response, error) in
			DispatchQueue.main.async {
				guard let data = data else {errorHandler(AppError.badData); return}
				completionHandler(data)
			}
		}
		task.resume() //start task
	}
}

//ImageHelper
struct ImageAPIClient {
	//Singleton
	private init() {}
	static let manager = ImageAPIClient()
	//Method to get Image
	func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {
		//guard URL for nil
		guard let url = URL(string: urlStr) else {errorHandler(.badURL);return}
		//Create Completion
		let completion: (Data) -> Void = {(data: Data) in
			guard let onlineImage = UIImage(data: data) else {return}
			completionHandler(onlineImage) //call completionHandler
		}
		//call NetworkHelper
		NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
	}
}


