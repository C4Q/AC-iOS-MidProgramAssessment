//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    var element: Element?
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let element = self.element else {return}
            self.nameLabel.text = element.name
        self.symbolLabel.text = element.symbol
       // self.symbolLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
        self.numberLabel.text = "\(element.number)"
        self.weightLabel.text = element.weight.description
        self.meltingLabel.text = "Melting Point: \(element.melting?.description ?? "Unknown")"
        self.boilingLabel.text = "Boiling Point: \(element.boiling?.description ?? "Unknown")"
        if let yearInt = element.discoverYearInt {
            self.yearLabel.text = "Discovery Year: \(yearInt)"
        } else if let yearStr = element.discoverYearStr {
            self.yearLabel.text = "Discovery Year: \(yearStr)"
        }
        
        let imageStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.imageView.image = onlineImage
        }
        ElementImageAPIClient.manager.getImages(from: imageStr, completionHandler: completion, errorHandler: {print($0)})
        // Do any additional setup after loading the view.
    }

  
    @IBAction func postButtonPressed(_ sender: UIButton) {
        guard let element = element else {return}
        let item = Favorite(name: "Xian", favorite_element: element.symbol )
        ElementAPIClient.manager.post(favorate: item, errorHandler: {print($0)})
    }
    
   

}
