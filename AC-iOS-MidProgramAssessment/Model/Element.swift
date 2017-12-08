//  Element.swift
//  AC-iOS-MidProgramAssessment
//  Created by Winston Maragh on 12/8/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

struct Element: Codable {
	let id: Int //1,
	let number: Int //1,
	let weight: Double //1.0079,
	let name: String //"Hydrogen",
	let symbol: String //"H",
	let meltingPoint: Int? //-259,
	let boilingPoint : Int?// -253,
	let discoveryYear: Int //1776,
	enum CodingKeys: String, CodingKey {
		case id
		case number
		case weight
		case name
		case symbol
		case meltingPoint = "melting_c"
		case boilingPoint = "boiling_c"
		case discoveryYear = "discovery_year"
	}
}

enum HTTPVerb: String {
	case GET
	case POST
}

struct ElementAPIClient {
	private init() {}
	static let manager = ElementAPIClient()
	//GET
	func getElements(completionHandler: @escaping ([Element]) -> Void,
								 errorHandler: @escaping (Error) -> Void) {
		let urlStr = URL(string: "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements")!
//		guard let authRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
		let parseData = {(data: Data) in
			do {
				let decodedElements = try JSONDecoder().decode([Element].self, from: data)
				completionHandler(decodedElements)
			}
			catch {errorHandler(AppError.codingError(rawError: error))}
		}
		NetworkHelper.manager.performDataTask(with: urlStr,
																					completionHandler: parseData,
																					errorHandler: errorHandler)
	}
	//POST
//	func postElement(element: (String, String), errorHandler: @escaping (Error) -> Void) {

	func postElement(element: Element, errorHandler: @escaping (Error) -> Void) {
		let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
		guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
		do {
			let encodedElement = try JSONEncoder().encode(element)
			authPostRequest.httpBody = encodedElement
			NetworkHelper.manager.performDataTask(with: authPostRequest,
																						completionHandler: {_ in print("Made a post request")},
																						errorHandler: errorHandler)
		} catch {errorHandler(AppError.codingError(rawError: error))}
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


//struct ElementAPIClient {
//	private init() {}
//	static let manager = ElementAPIClient()
//	func getElements(from urlStr: String,
//									 completionHandler: @escaping ([Element])->Void,
//									 errorHandler: @escaping (Error) -> Void) {
//		guard let url = URL(string: urlStr) else {return}
//		let completion: (Data)->Void = {(data: Data) in
//			do{
//				let elements = try JSONDecoder().decode([Element].self, from: data)
//				completionHandler(elements)
//			}
//			catch {print(error)}
//		}
//		NetworkHelper.manager.performDataTask(with: url,
//																					completionHandler: completion,
//																					errorHandler: {(print($0))})
//	}
//}



//Auth with AppKey & AppID
//struct RecipeAPIClient {
//	private init() {}
//	static let manager = RecipeAPIClient()
//	func getRecipes(named searchStr: String, completionHandler: @escaping ([Recipe])->Void, errorHandler: @escaping (Error)->Void) {
//		let appID = "a71ffef8"
//		let appKey = "5e374933f3f8de8c5959a76e6488bafc"
//		let urlStr = "https://api.edamam.com/search?q=\(searchStr)&app_id=\(appID)&app_key=\(appKey)"
//
//		guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
//		let completion: (Data)->Void = {(data: Data) in
//			do {
//				let recipeInfo = try JSONDecoder().decode(AllRecipeInfo.self, from: data)
//				let RecipeWrappers = recipeInfo.hits
//				let recipes = RecipeWrappers.map({$0.recipe})
//				completionHandler(recipes)
//			}
//			catch let error {
//				errorHandler(AppError.codingError(rawError: error))
//			}
//		}
//		NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
//	}
//}
