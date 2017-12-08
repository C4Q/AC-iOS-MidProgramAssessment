//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var element: Element!
    
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementPicture: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMeltingPoint: UILabel!
    @IBOutlet weak var elementBoilingPoint: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementNumber.text = element.number.description
        elementSymbol.text = element.symbol
        elementName.text = element.name
        elementWeight.text = element.weight.description
        
        if element.melting_c != nil {
            elementMeltingPoint.text = "Melting Point: " + (element.melting_c?.description)! + "C"
        } else { elementMeltingPoint.text = "N/A"}
        if element.boiling_c != nil{
            elementBoilingPoint.text = "Boiling Point: " + (element.boiling_c?.description)! + "C"
        }else{
            elementBoilingPoint.text = "N/A"}
        
        
        if element.number < 90{
        
        let lowercasedElementName = element.name.lowercased()
        let urlStr = "http://images-of-elements.com/\(lowercasedElementName).jpg"
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementPicture.image = onlineImage
            self.activityIndicator.stopAnimating()
        }
        
        self.activityIndicator.startAnimating()
        ImageAPIClient.manager.getImage(from: urlStr, completionHandler: completion, errorHandler: {print($0)})

        } else{
            activityIndicator.stopAnimating()
            self.elementPicture.image = #imageLiteral(resourceName: "image_not_available")
        }
    }

    @IBAction func postPressed(_ sender: UIButton) {
        let newElement = ElementPost(name: "alan", favorite_element: element.symbol)
        ElementAPIClient.manager.post(elementPost: newElement, completionHandler: {print($0)}, errorHandler: {print($0)})
        
    }
        
        
    }
