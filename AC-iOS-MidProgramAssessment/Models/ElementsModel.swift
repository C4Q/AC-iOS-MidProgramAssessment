//
//  ElementsModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ElementsClass: Codable {
    static var apiEndPoint = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
    var number: Int
    //Make a computed property for element numbers to be 3 digits by adding a 0 to the prefix until its count is 3 for the thumbnail image search.
    //Thumbnail (for table view): http://www.theodoregray.com/periodictable/Tiles/ElementNumberWithThreeDigits/s7.JPG
    //Example: http://www.theodoregray.com/periodictable/Tiles/018/s7.JPG
    var thumbnailLink: String {
        var threeDigitVersion = String(number)
        while threeDigitVersion.count < 3 {
            threeDigitVersion = "0" + threeDigitVersion
        }
        let computedThumbLink = "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitVersion)/s7.JPG"
        return computedThumbLink
    }
    
    var weight: Double
    var name: String
    //Make a computed property to lowercase the element name for the fullsize jpg image search. OR just .lowercased()
    //Full-size: (for detail view): http://images-of-elements.com/lowercasedElementName.jpg
    //Example: http://images-of-elements.com/argon.jpg
    var largeImageLink: String {
        let computedImageLink = "http://images-of-elements.com/\(name.lowercased()).jpg"
        return computedImageLink
    }
    var symbol: String
    var meltingPoint: Int?
    var boilingPoint: Int?
    var density: Double?
    //var discoveryYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case weight = "weight"
        case name = "name"
        case symbol = "symbol"
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        case density = "density"
        //case discoveryYear = "discovery_year"
    }
}

struct ElementsAPIClient {
    private init() {}
    static let manager = ElementsAPIClient()
    //THIS FUNC MAKES THE DATA ARRAY
    func getElementsArray(from urlStr: String,
                        completionHandler: @escaping ([ElementsClass]) -> Void,
                        errorHandler: @escaping (Error) -> Void) {
        
        let urlreq = URLRequest(url: URL(string: urlStr)!)
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let elementsFromTheInternet = try JSONDecoder().decode([ElementsClass].self, from: data)
                let elements: [ElementsClass] = elementsFromTheInternet
                completionHandler(elements)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        //This is were you call the NetworkHelper based off if the url, completion closure, and error closure made above this line.
        NetworkHelper.manager.performDataTask(with: urlreq, completionHandler: completion, errorHandler: errorHandler)
        
    }
}

