//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var element: Elements!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setImage()
    }
    
    @IBAction func addFavoritesButtonPressed(_ sender: UIButton) {
        let newFavorites = Favorites(name: "Ty", favorite_element: element.name)
        ElementsAPIClient.manager.post(favorite: newFavorites, errorHandler: {print($0)})
        let alert =  UIAlertController(title: "Post", message: "Posted to Favorites", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    
    func setupUI() {
        symbolLabel.text = "Symbol: \(element.symbol)"
        numberLabel.text = "Number: \(element.number)"
        weightLabel.text = "Weight: \(element.weight)"
        boilingPointLabel.text = element.boiling_c != nil ? "Boiling Point: \(element.boiling_c!) C" : "Boiling Point: N/A"
        meltingPointLabel.text = element.melting_c != nil ? "Melting Point: \(element.melting_c!) C" : "Melting Point: N/A"
    }
    
    func setImage() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        let imageUrlStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementImage.image = onlineImage
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHander: completion,
                                        errorHandler: {print($0)})
    }
}






