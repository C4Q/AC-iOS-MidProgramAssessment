//
//  ElementsModel.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ElementsClass: Codable {
    var number: Int
    //Make a computed property for element numbers to be 3 digits by adding a 0 to the prefix until its count is 3 for the thumbnail image search.
    //Thumbnail (for table view): http://www.theodoregray.com/periodictable/Tiles/ElementNumberWithThreeDigits/s7.JPG
    //Example: http://www.theodoregray.com/periodictable/Tiles/018/s7.JPG
    var threeDigitNumber: String {
        var threeDigitVersion = String(number)
        while threeDigitVersion.count < 3 {
            threeDigitVersion = "0" + threeDigitVersion
        }
        return threeDigitVersion
    }
    
    var weight: Double
    var name: String
    //Make a computed property to lowercase the element name for the fullsize jpg image search.
    //Full-size: (for detail view): http://images-of-elements.com/lowercasedElementName.jpg
    //Example: http://images-of-elements.com/argon.jpg
    var symbol: String
    var meltingPoint: Int?
    var boilingPoint: Int?
    var density: Double?
    var discoveryYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case weight = "weight"
        case name = "name"
        case symbol = "symbol"
        case meltingPoint = "melting_c"
        case boilingPoint = "boiling_c"
        case density = "density"
        case discoveryYear = "discovery_year"
    }
}

/*
struct ImagesAPIClient {
    private init() {}
    static let manager = ImagesAPIClient()
    //THIS FUNC MAKES THE DATA ARRAY
    func getImagesArray(from urlStr: String,
                        completionHandler: @escaping ([ImageData]) -> Void,
                        errorHandler: @escaping (Error) -> Void) {
        //guard let url = URL(string: urlStr) else {return}
        
        let urlreq = URLRequest(url: URL(string: urlStr)!)
        
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let picturesFromTheInternet = try JSONDecoder().decode(OnlineImages.self, from: data)
                let images: [ImageData] = picturesFromTheInternet.hits
                completionHandler(images)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        //This is were you call the NetworkHelper based off if the url, completion closure, and error closure made above this line.
        NetworkHelper.manager.performDataTask(with: urlreq, completionHandler: completion, errorHandler: errorHandler)
        
    }
}
 */
