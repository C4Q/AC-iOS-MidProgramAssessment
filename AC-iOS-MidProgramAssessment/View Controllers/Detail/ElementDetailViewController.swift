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
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var discoveryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorize()
        
        self.symbolLabel.text = self.chosenElement.symbol
        self.weightLabel.text = "Standard atomc weight of \(String(describing: self.chosenElement.weight))"
        self.numberLabel.text = String(self.chosenElement.number)
        
        if let boilingPoint = self.chosenElement.boilingPoint {
            self.boilingLabel.text = "Boils at \(String(describing: boilingPoint))℃"
        } else {
            self.boilingLabel.text = "N/A"
        }
        
        if let meltingPoint = self.chosenElement.meltingPoint {
            self.meltingLabel.text = "Melts at \(String(describing: meltingPoint))℃"
        } else {
            self.meltingLabel.text = "N/A"
        }
        
        if self.chosenElement.yearDiscovered == "ancient" {
            self.discoveryLabel.text = "Discovered in \(String(describing: self.chosenElement.yearDiscovered!)) times"
        } else {
            self.discoveryLabel.text = "Discovered in \(String(describing: self.chosenElement.yearDiscovered!))"
        }
        
        self.fullsizePic.image = self.chosenElement.fullsizePic
    }
    
    @IBAction func favoriteButtonWasTapped(_ sender: UIButton) {
        let data: [String: Any] = ["name": "Marty", "favorite_element": "\(String(describing: chosenElement.symbol))"]
        dump(data)
        
        guard let url = URL(string: NetworkPath.favoritePostAddress) else {
            return
        }
        
        APIRequestManager.shared.postRequest(to: url, data: data)

    }
    
    func colorize() {
        if self.chosenElement.number % 2 == 0 {
            self.view.backgroundColor = UIColor.yellow
            self.symbolLabel.textColor = UIColor.black
            self.weightLabel.textColor = UIColor.black
            self.numberLabel.textColor = UIColor.black
            self.boilingLabel.textColor = UIColor.black
            self.meltingLabel.textColor = UIColor.black
            self.discoveryLabel.textColor = UIColor.black
        } else {
            self.view.backgroundColor = UIColor.black
            self.symbolLabel.textColor = UIColor.yellow
            self.weightLabel.textColor = UIColor.yellow
            self.numberLabel.textColor = UIColor.yellow
            self.boilingLabel.textColor = UIColor.yellow
            self.meltingLabel.textColor = UIColor.yellow
            self.discoveryLabel.textColor = UIColor.yellow
        }
    }
}
