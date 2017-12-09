//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveryYearLabel: UILabel!
    @IBOutlet weak var elementLargeImage: UIImageView!
    
    var elementPassed: Element!
    var elementName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadElementData()
    }

    func loadElementData() {
        loadMyImage2()
        nameLabel.text = elementPassed.name
        weightLabel.text = elementPassed.weight.description
        numberLabel.text = elementPassed.number.description
        symbolLabel.text = elementPassed.symbol
        meltingPointLabel.text = "Melting Point: \(elementPassed.melting!.description)"
        boilingPointLabel.text = "BoilingPoit: \(elementPassed.boiling!.description)"
        //discoveryYearLabel.text = elementPassed.discoveryYear?.description
    }
    
    func loadMyImage2() {
        var urlStr = ""
        if let elementName = elementPassed.name?.lowercased() {
        urlStr = "http://images-of-elements.com/\(elementName).jpg"
        }
        let setElementsToOnlineElements: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementLargeImage.image = onlineImage
        }
        ImageAPIClient.manager.getImage(from: urlStr,
                                        completionHandler:setElementsToOnlineElements,
                                        errorHandler: {print($0)})
    }
    
    //MARK: POST REQUEST
    @IBAction func postButtonPressed(_ sender: Any) {
        let myPost = MyfaveElement(myName: "Kaniz", favorite_element:elementPassed.name!)
        MyFavoriteElementAPIClient.manager.post(fav: myPost){ print($0) }
    }
}





