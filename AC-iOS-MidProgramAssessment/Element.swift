//
//  Element.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit
struct Element: Codable {
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let melting: Double?
    let boiling: Double?
    var discoverYearInt: Int?
    var discoverYearStr: String?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case symbol = "symbol"
        case number = "number"
        case weight = "weight"
        case melting = "melting_c"
        case boiling = "boiling_c"
        case discoverYearInt = "discovery_year"
    }
    
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try values.decode(String.self, forKey: .name)
            self.symbol = try values.decode(String.self, forKey: .symbol)
            self.number = try values.decode(Int.self, forKey: .number)
            self.weight = try values.decode(Double.self, forKey: .weight)
            self.melting = try? values.decode(Double.self, forKey: .melting)
            self.boiling = try? values.decode(Double.self, forKey: .boiling)
            if let yearInt = try? values.decode(Int.self, forKey: .discoverYearInt) {
                discoverYearInt = yearInt
            } else if let yearStr = try? values.decode(String.self, forKey: .discoverYearInt) {
                discoverYearStr = yearStr
            }
}
}
/*

class ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElement(from urlStr: String,
                    completionHandler: @escaping ([Element]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        guard let myUrl = URL(string: urlStr) else {return}
        let urlRequest = URLRequest(url: myUrl)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let elementArr = try JSONDecoder().decode([Element].self, from: data)
                completionHandler(elementArr)
            } catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performTask(from: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}

class ElementImageAPIClient {
    private init() {}
    static let manager = ElementImageAPIClient()
    func getImages(from imageStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let imageUrl = URL(string: imageStr) else {return}
        let urlRequest = URLRequest(url: imageUrl)
        let completion: (Data) -> Void = {(data: Data) in
            if let onlineImage = UIImage(data: data) {
            completionHandler(onlineImage)
            }
        }
        NetworkHelper.manager.performTask(from: urlRequest, completionHandler: completion, errorHandler: errorHandler)
        
    }
}
*/

