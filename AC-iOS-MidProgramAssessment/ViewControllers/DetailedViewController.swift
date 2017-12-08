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
    
    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var elementLetterLabel: UILabel!
    
    @IBOutlet weak var elementNameLabe: UILabel!
    
    @IBOutlet weak var atomicWeightLabel: UILabel!
    
    @IBOutlet weak var meltingboilingPointLabel: UILabel!
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        //Insert POST Function Call Here
        
    }
    
    var aSeguedElement: ElementsClass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
