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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let element = element else { return }
        titleNameLabel.text = element.name
        if let meltingPoint = element.melting_c { meltingPointLabel.text = "Melting Point: \(meltingPoint.description)" }
        else { meltingPointLabel.text = "Melting Point N/A" }
        if let boilingPoint = element.boiling_c { boilingPointLabel.text = "Boiling Point: \(boilingPoint.description)" }
        else { boilingPointLabel.text = "Boiling Point N/A" }
        discoveryNameLabel.text = "Coming soon..."
        if element.id >= 90 {
            elementImage.image = UIImage(named: "noImageFound")
            return
        }
        loadLargeElemImage(element: element)
    }
    
    func loadLargeElemImage(element: Element) {
        let largeImageURLStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        let imageCompletion: (UIImage) -> Void = { (onlineLargeImage: UIImage) in
            self.elementImage.image = onlineLargeImage
            self.elementImage.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: largeImageURLStr, completionHandler: imageCompletion, errorHandler: {print($0)} )
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
    }
    

}
