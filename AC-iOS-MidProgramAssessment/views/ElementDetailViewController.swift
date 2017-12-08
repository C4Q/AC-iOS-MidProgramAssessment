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
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
       let myPost = FieldBook(name: "Iram", favorite_element: anElement.symbol)
        FieldBookAPIClient.manager.post(fieldbookpost: myPost, completionHandler: {print($0)}, errorHandler: {print($0)})
    }
    
    
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




}
