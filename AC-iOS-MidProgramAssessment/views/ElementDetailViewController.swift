//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    
    @IBOutlet weak var elementBigImage: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var meltingLabel: UILabel!
    
    
    @IBOutlet weak var boilingLabel: UILabel!
    
    var anElement: Element!
    
    func setUp() {
        navigationItem.title = anElement.name
        nameLabel.text = anElement.name
        symbolLabel.text = anElement.symbol
        numberLabel.text = anElement.number.description
        weightLabel.text = anElement.weight.description
        meltingLabel.text = "Melting Point: \(anElement.boiling_c ?? 0)"
        boilingLabel.text = "Boiling Point: \(anElement.boiling_c ?? 0)"
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black 
        setUp()
       
    }

//    let bigImageUrl = "http://images-of-elements.com/\(anElement.name.lowercased()).jpg"
//
//    let getBigImage: (UIImage) -> Void = {(onlineImage: UIImage) in
//        self.elementBigImage.image = onlineImage
//
//    }
//    ImageAPIClient.manager.getImage(from: bigImageUrl, completionHandler: getBigImage, errorHandler: {print($0)})
//


}
