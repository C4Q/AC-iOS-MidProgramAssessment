//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var element: Element?
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveryNameLabel: UILabel!
    
    @IBOutlet weak var elementNumberLabel: UILabel!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementAtomicWeightLabel: UILabel!
    @IBOutlet weak var largeImageSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementImage.alpha = 0.8
        guard let element = element else { return }
        largeImageSpinner.startAnimating()
        titleNameLabel.text = element.name
        if let meltingPoint = element.melting_c { meltingPointLabel.text = "Melting Point: \(meltingPoint.description) °C" }
        else { meltingPointLabel.text = "Melting Point: N/A" }
        if let boilingPoint = element.boiling_c { boilingPointLabel.text = "Boiling Point: \(boilingPoint.description) °C" }
        else { boilingPointLabel.text = "Boiling Point: N/A" }
        if let yearAsInt = element.discovery_year_int { discoveryNameLabel.text = "Discovered: \(yearAsInt.description)" }
        else { discoveryNameLabel.text = "Discovered: \(element.discovery_year_Str!)" }
        if element.id >= 90 {
            hideSpinner()
            elementImage.image = UIImage(named: "noImageFound")
            setAndshowElementLabels()
            return
        }
        loadLargeElemImage(element: element)
    }
    
    func loadLargeElemImage(element: Element) {
        let largeImageURLStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        let imageCompletion: (UIImage) -> Void = { (onlineLargeImage: UIImage) in
            self.elementImage.image = onlineLargeImage
            self.elementImage.setNeedsLayout()
            self.setAndshowElementLabels()
            self.hideSpinner()
        }
        ImageAPIClient.manager.getImage(from: largeImageURLStr, completionHandler: imageCompletion, errorHandler: {print($0)} )
    }
    
    func setAndshowElementLabels() {
        guard let element = element else { return }
        elementNumberLabel.text = element.id.description
        elementSymbolLabel.text = element.symbol
        elementNameLabel.text = element.name
        elementAtomicWeightLabel.text = element.weight.description
        elementNumberLabel.isHidden = false
        elementSymbolLabel.isHidden = false
        elementNameLabel.isHidden = false
        elementAtomicWeightLabel.isHidden = false
    }
    
    func hideSpinner() {
        largeImageSpinner.stopAnimating()
        largeImageSpinner.isHidden = true
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        guard let element = element else { return }
        let myFavElement = FavElement(name: "Luis", favorite_element: element.symbol)
        FavElementAPIClient.manager.post(favElement: myFavElement, errorHandler: {print($0)})
    }
    

}
