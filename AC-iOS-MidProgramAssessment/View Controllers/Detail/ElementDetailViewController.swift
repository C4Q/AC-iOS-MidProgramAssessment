//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    var chosenElement: Element!
    
    @IBOutlet weak var fullsizePic: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var discoveryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.symbolLabel.text = self.chosenElement.name
        self.nameLabel.text = self.chosenElement.name
        self.numberLabel.text = String(self.chosenElement.number)
        self.boilingLabel.text = String(describing: self.chosenElement.boilingPoint)
        self.meltingLabel.text = String(describing: self.chosenElement.meltingPoint)
        self.discoveryLabel.text = "Discovered: \(self.chosenElement.yearDiscovered)"
    }

}
