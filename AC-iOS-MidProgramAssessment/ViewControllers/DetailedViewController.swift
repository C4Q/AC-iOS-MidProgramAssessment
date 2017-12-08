//
//  DetailedViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var elementNumberLabel: UILabel!
    
    @IBOutlet weak var elementLetterLabel: UILabel!
    
    @IBOutlet weak var elementNameLabe: UILabel!
    
    @IBOutlet weak var atomicWeightLabel: UILabel!
    
    @IBOutlet weak var meltingboilingPointLabel: UILabel!
    
    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        //Insert POST Function Call Here
        let myPost = FieldBook(favorite_element: aSeguedElement.largeImageLink, name: "Responsible Richard aka String Master Hokage of the Git Gud Clan")
        FieldBookAPIClient.manager.postImg(fieldbookpost: myPost, completionHandler: {print($0)}, errorHandler: {print($0)})
    }
    
    var aSeguedElement: ElementsClass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsAndImages()
        
    }
    func setLabelsAndImages() {
        elementNumberLabel.text = "\(aSeguedElement.number)"
        elementLetterLabel.text = "\(aSeguedElement.symbol)"
        elementNameLabe.text = "\(aSeguedElement.name)"
        atomicWeightLabel.text = "\(aSeguedElement.weight)"
        
        //To check for nils
        var meltingPoint = ""
        var boilingPoint = ""
        //let discoveryYear = "\(aSeguedElement.discoveryYear ?? "Unknown")"
        if aSeguedElement.meltingPoint == nil {
            meltingPoint = "Unknown"
        } else {
            meltingPoint = String(aSeguedElement.meltingPoint!)
        }
        if aSeguedElement.boilingPoint == nil {
            boilingPoint = "Unknown"
        } else {
            boilingPoint = String(aSeguedElement.boilingPoint!)
        }
        
        meltingboilingPointLabel.text = "Melting Point: \(meltingPoint). Boiling Point: \(boilingPoint)."
        
        let bigImageUrl = aSeguedElement.largeImageLink
        let getTheImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementImageView.image = onlineImage
        }
        
        ImageAPIClient.manager.getImage(from: bigImageUrl, completionHandler: getTheImage, errorHandler: {print($0)})
    }
        
}

