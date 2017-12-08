//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementAtomicNumberLabel: UILabel!
    @IBOutlet weak var elementWeightLabel: UILabel!
    @IBOutlet weak var elementMeltingPointLabel: UILabel!
    @IBOutlet weak var elementBoilingPointLabel: UILabel!
    @IBOutlet weak var elementYearDiscoveredLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let element = element else { return }
        spinner.isHidden = false
        spinner.startAnimating()
        self.navigationItem.title = element.name
        elementSymbolLabel.text = element.symbol
        elementAtomicNumberLabel.text = "\(element.number)"
        elementWeightLabel.text = "\(element.weight)"
        if let meltingP = element.meltingPoint {
            elementMeltingPointLabel.text = "Melting Point: " + String(meltingP)
        } else {
            elementMeltingPointLabel.text = "Unknown Melting Point"
        }
        if let boilingP = element.boilingPoint {
            elementBoilingPointLabel.text = "Boiling Point: " + String(boilingP)
        } else {
            elementBoilingPointLabel.text = "Unknown Boiling Point"
        }
        var discoveryYear = ""
        if let dy = element.discoveryYearInt {
            discoveryYear = String(dy)
        } else if let dy = element.discoveryYearStr {
            discoveryYear = dy
        } else {
            discoveryYear = "Uknown"
        }
        elementYearDiscoveredLabel.text = "Year Discovered: \(discoveryYear)"
        if element.number < 90 {
        let imgURL = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
            ImageAPIClient.manager.getImage(from: imgURL,
                completionHandler: { self.elementImageView.image = $0
                DispatchQueue.main.async {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                } },
                errorHandler: { print($0) })
        } else {
            spinner.isHidden = true
            spinner.stopAnimating()
            elementImageView.image = #imageLiteral(resourceName: "no-image")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Button Actions
    
    @IBAction func postFavElementButtonTapped(_ sender: UIButton) {
        guard let element = element else { return }
        
        let post = FavElement(name: "Reiaz", favElement: "\(element.name)")
        
        FieldBookAPIClient.manager.postFavElement(favElement: post, completionHandler: { print($0) }, errorHandler: { print($0) })
    }
    
}
