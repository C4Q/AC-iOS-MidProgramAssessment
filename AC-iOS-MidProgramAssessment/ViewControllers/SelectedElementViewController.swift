//
//  SelectedElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SelectedElementViewController: UIViewController {
    
    var selectedElement: ElementInfo!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBAction func favoriteButton(_ sender: UIButton) {
        let favoritedElement = ElementPost(name: "Kash", favorite_element: selectedElement.symbol)
        ElementAPIClient.manager.postFavorite(favElement: favoritedElement, errorHandler: {_ in print(Error.self)})
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedElement.name
        symbolLabel.text = "Symbol: \(selectedElement.symbol)"
        numberLabel.text = "Number: \(selectedElement.number)"
        weightLabel.text = "Weight: \(selectedElement.weight)"
        
        if selectedElement.melting_c != nil {
            meltingPointLabel.text = "Melting Point: \(selectedElement.melting_c!) C"
        } else {
            meltingPointLabel.text = "Melting Point: No melting point available."
        }
        if selectedElement.boiling_c != nil {
            boilingPointLabel.text = "Boiling Point: \(selectedElement.boiling_c!) C"
        } else {
            boilingPointLabel.text = "Boiling Point: No boiling point available."
        }
        
        if selectedElement.number < 90 {
            let lowercasedName = selectedElement.name.lowercased()
            let imageUrlStr = "http://images-of-elements.com/\(lowercasedName).jpg"
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.elementImage.image = onlineImage
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr,
                                            completionHandler: completion,
                                            errorHandler: {print($0)})
        } else {
            self.elementImage.image = #imageLiteral(resourceName: "NoImageFound")
        }
    }

}
