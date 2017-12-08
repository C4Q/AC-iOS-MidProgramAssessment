//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Lisa J on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    var element: Element!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var symbolLabel:UILabel!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var weightLabel:UILabel!
    @IBOutlet weak var meltingLabel:UILabel!
    @IBOutlet weak var boilingLabel:UILabel!
    // @IBOutlet weak var discoveryLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImg()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        idLabel.text = "\(element.id)"
        symbolLabel.text = element.symbol
        nameLabel.text = element.name
        weightLabel.text = "\(element.weight)"
        meltingLabel.text = "Melting Point: \(element.melting_c != nil ? "\(element.melting_c!)": "N/A")"
        boilingLabel.text = "Boiling Point: \(element.boiling_c != nil ? "\(element.boiling_c!)": "N/A")"
        
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        let myName = "Lisa"
        let chosenElement = element.name
        let faveElement = FaveElement(name: myName, favorite_element: chosenElement)
        ElementAPIClient.manager.post(element: faveElement, errorHandler: {print($0)})
        
    }
    func loadImg() {
        let elementName = element.name.lowercased()
        //let elementId = element.id
        let imageUrl = "http://images-of-elements.com/\(elementName).jpg"
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.imgView.image = onlineImage
        }
        
        ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: completion, errorHandler: {print($0)})
        //            }
        //        }
    }
    
}
