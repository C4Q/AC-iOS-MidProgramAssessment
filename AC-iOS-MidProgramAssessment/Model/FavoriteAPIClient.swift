//  FavoriteAPIClient.swift
//  AC-iOS-MidProgramAssessment
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

struct FavoriteAPIClient {
	private init(){}
	static let manager = FavoriteAPIClient()
	//POST
	func post(favorite: Favorite, errorHandler: @escaping (Error) -> Void) {
		let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
		guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
		do {
			let favorite = try JSONEncoder().encode(favorite)
			authPostRequest.httpBody = favorite
			NetworkHelper.manager.performDataTask(withURLRequest: authPostRequest, completionHandler: {_ in print("Made a post request")}, errorHandler: errorHandler)
		}
		catch { errorHandler(AppError.codingError(rawError: error)) }
	}

	//	AUTHENTICATION REQUEST
	private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
		guard let url = URL(string: urlStr) else { return nil }
		var request = URLRequest(url: url)
		let userName = "key-1"
		let password = "ptJP0XOFIQ_xysF7nwoB"
		let authStr = buildAuthStr(userName: userName, password: password)
		request.addValue(authStr, forHTTPHeaderField: "Authorization")
		if httpVerb == .POST {
			request.httpMethod = "POST"
			request.addValue("application/json", forHTTPHeaderField: "Accept")
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		}
		return request
	}

	//	build BASIC AUTHENTICATION INFO
	private func buildAuthStr(userName: String, password: String) -> String {
		let nameAndPassStr = "\(userName):\(password)"
		let nameAndPassData = nameAndPassStr.data(using: .utf8)!
		let authBase64Str = nameAndPassData.base64EncodedString()
		let authStr = "Basic \(authBase64Str)"
		return authStr
	}
}

