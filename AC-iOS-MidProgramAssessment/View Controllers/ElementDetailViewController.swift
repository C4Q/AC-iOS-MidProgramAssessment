//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Maryann Yin on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var elementInfo: ElementWrapper!

    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var meltingPointLabel: UILabel!
    
    @IBOutlet weak var boilingPointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symbolLabel.text = elementInfo.symbol
        numberLabel.text = elementInfo.name.description
        weightLabel.text = elementInfo.weight.description
        meltingPointLabel.text = elementInfo.meltingPointInC?.description
        boilingPointLabel.text = elementInfo.boilingPointInC?.description
    }
    
}
