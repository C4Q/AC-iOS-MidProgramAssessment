//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

struct ElementAPIClient {
	private init() {}
	static let manager = ElementAPIClient()
	func getElements(completionHandler: @escaping ([Element])->Void, errorHandler: @escaping (AppError)->Void){
		let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
		guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
		let completion: (Data)->Void = {(data: Data) in
			do {
				let elements = try JSONDecoder().decode([Element].self, from: data)
				print(elements)
				completionHandler(elements)
			}
			catch let error { errorHandler(AppError.codingError(rawError: error)); return }
		}
		NetworkHelper.manager.performDataTask(withURL: url, completionHandler: completion, errorHandler: errorHandler)
	}
}
