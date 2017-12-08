//
//  ElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    var element: Element!
    
    //Turn to array of labels?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var atomicWeightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    //    @IBOutlet weak var yearDiscoveredLabel: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = element.name
        loadLabels()
        loadImageView()
        
    }
    
    func loadLabels() {
        nameLabel?.text = element.name
        symbolLabel?.text = element.symbol
        numberLabel?.text = element.number.description
        atomicWeightLabel?.text = element.weight.description
        meltingPointLabel?.text = "Melting Point(°C): \((element.melting_c?.description) ?? "Not available")"
        boilingPointLabel?.text = "Boiling Point(°C): \(element.boiling_c?.description ?? "Not available")"
        //        yearDiscoveredLabel?.text = "Year Discovered: \(element.discovery_year)"
    }
    
    func loadImageView() {
        //if image no loady, check here!
        let imageUrlStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        guard let url = URL(string: imageUrlStr) else { print("problem with url");return }
        guard let rawImageData = try? Data(contentsOf: url) else { self.elementImageView.image = #imageLiteral(resourceName: "not-available"); return }
        //^---Some image urls were not working (ex: thorium, uranium) so used placeholder image
        guard let onlineImage = UIImage(data: rawImageData) else { print("problem with turning to uiimage");return }
        self.elementImageView.image = onlineImage
        self.elementImageView.layer.borderWidth = 1.0
        self.elementImageView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        let imagePosterAndImage = PostFavElement(name: "Gloria", favorite_element: element.symbol)
        PostFavoriteElementAPI.manager.postFavElement(element: imagePosterAndImage, errorHandler: {print("Error: \($0)")})
    }
}














