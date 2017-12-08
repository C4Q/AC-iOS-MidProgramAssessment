//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveryYear: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var showSpinner: UIActivityIndicatorView!
    
    
    var selectedElement: Element!
    
    func loadViews() {
        self.number.text = "\(selectedElement.number)"
        self.symbol.text = selectedElement.symbol
        self.name.text = selectedElement.name
        self.weight.text = "\(selectedElement.weight)"
        if let mp = selectedElement.meltingPoint {
            self.meltingPoint.text = "Melting Point: \(mp) °C"
        } else {
            self.meltingPoint.text = "Melting Point: Unknown"
        }
        if let bp = selectedElement.boilingPoint {
            self.boilingPoint.text = "Boiling Point: \(bp) °C"
        } else {
            self.boilingPoint.text = "Boiling Point: Unknown"
        }
        switch selectedElement.discoveryYear {
        case .int(let year): self.discoveryYear.text = "Discovered: \(year)"
        case .string(let year): self.discoveryYear.text = "Discovered: " + year
        }
        
        self.backgroundImage.image = nil
        self.showSpinner.isHidden = false
        self.showSpinner.startAnimating()
        
        let urlStr = "http://images-of-elements.com/\(selectedElement.name.lowercased()).jpg"
        let setBGImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.backgroundImage.image = onlineImage
            self.backgroundImage.alpha = CGFloat(0.69)
            self.showSpinner.isHidden = true
            self.showSpinner.stopAnimating()
        }
        ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setBGImageToOnlineImage, errorHandler: {
            self.backgroundImage.image = #imageLiteral(resourceName: "no-image")
            self.backgroundImage.alpha = CGFloat(0.50)
            self.showSpinner.isHidden = true
            self.showSpinner.stopAnimating()
            print($0)
        })
    }
    
    var myFavorites = [Favorite]()
    func loadFavorites() {
        let setFavoritesToOnlineFavorites: ([Favorite]) -> Void = {(onlineFavorites: [Favorite]) in
            self.myFavorites = onlineFavorites
        }
        FavoriteAPIClient.manager.getMyFavorites(completionHandler: setFavoritesToOnlineFavorites, errorHandler: {print($0)})
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedElement.name
        loadViews()
        loadFavorites()
    }
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        let favoriteElements = self.myFavorites.map{$0.favoriteElement}
        guard !favoriteElements.contains(selectedElement.symbol) else {return}
        
        let favorite = Favorite(name: "Diego", favoriteElement: selectedElement.symbol)
        FavoriteAPIClient.manager.post(favorite: favorite, errorHandler: {print($0)})
        self.myFavorites.append(favorite)
    }
    
    
}
