//
//  DetailElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailElementViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveryYearLabel: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnFavorite.isEnabled = true
        loadLabels()
    }
    
    @IBAction func add2Favorite(_ sender: UIButton) {
        //Make POST request with orderName and orderCost
        let newFavorite = Favorite(name: "Marlon", favoriteElement: element.name)
        ElementsAPIClient.manager.post(favorite: newFavorite){print($0)}
        let alert = UIAlertController(title: "Saved", message: "\(element.name) has been added to Favorite", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        self.btnFavorite.isEnabled = false
    }
    func loadLabels() {
        self.numberLabel.text = "\(self.element.number)"
        self.nameLabel.text = self.element.name
        self.symbolLabel.text = self.element.symbol
        self.weightLabel.text = "\(self.element.weight)"
        self.meltingPointLabel.text = "Melting Point: \(self.element.meltingC ?? 0.0)"
        self.boilingPointLabel.text = "Boiling Point: \(self.element.boilingC ?? 0.0)"
        if let discoveryYear = self.element.discoveryYear {
            self.discoveryYearLabel.text = "Discovery: \(discoveryYear)"
        } else {
            self.discoveryYearLabel.text = "Discovery: \(self.element.discoveryYearStr ?? "")"
        }
        let imageStr = self.element.name.lowercased()
        let urlStr = "http://images-of-elements.com/\(imageStr).jpg"
        let setImageElement: (UIImage) -> Void = {(imageFromOnline: UIImage) in
            self.elementImageView.image = imageFromOnline
        }
        ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setImageElement, errorHandler: {print($0)})
    }
}
