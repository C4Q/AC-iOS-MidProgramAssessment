//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementNumberLabel: UILabel!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementWeightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    var element: Element!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementNumberLabel.text = "\(element.number)"
        elementSymbolLabel.text = element?.symbol
        elementNameLabel.text = element?.name
        elementWeightLabel.text = element?.weight.description
        meltingPointLabel?.text = "Melting Point (C): \(element?.meltingPointInCelsius?.description ?? "N/A")"
        boilingPointLabel?.text = "Boiling Point (C): \(element?.boilingPointInCelsius?.description ?? "N/A")"
//        elementImageView.image = nil
        loadImage()
    }
    
    
    func loadImage() {
        let elementNameLowercased = element.name.lowercased()
        let imageURLStr = "http://images-of-elements.com/\(elementNameLowercased).jpg"
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementImageView.image = onlineImage
            self.elementImageView.setNeedsLayout()
        }
        ElementImageAPIClient.manager.getImage(from: imageURLStr, completionHandler: completion, errorHandler: {print($0)})
        
    }

    @IBAction func addToFavsButtonPressed(_ sender: Any) {

        let addFavorite = FavoriteElement(name: "Maggie", favorite_element: element.name)
        FavoriteAPIClient.manager.add(favorite: addFavorite){ print($0) }
        
    }
}
