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
        //Insert Post Function Call Here
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
