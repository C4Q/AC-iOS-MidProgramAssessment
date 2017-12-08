//
//  DetailedElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedElementViewController: UIViewController {
    var element: Element?
    
    @IBOutlet weak var elementBackGroundImage: UIImageView!
    @IBOutlet weak var discoverYear: UILabel!
    @IBOutlet weak var elementBoilingPoint: UILabel!
    @IBOutlet weak var elementMeltingPoint: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var ElementSymbol: UILabel!
    @IBOutlet weak var elementTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let element = element else {
            return
        }
        self.elementTitle.text = element.name
        self.ElementSymbol.text = element.symbol
        self.elementWeight.text = element.weight.description
        self.elementBoilingPoint.text = "Boiling Point: \(element.boilingPointDegCel?.description ?? "No Registerd Boiling Point")"
        self.elementMeltingPoint.text = "Melting Point: \(element.meltingPointDegCel?.description ?? "No Registerd Melting Point")"
        self.elementNumber.text = element.number.description
        self.elementBackGroundImage.image = nil
        
        // move them to viewWillLayout
        ImageAPIClient.manager.getImage(from: "http://images-of-elements.com/\(element.name.lowercased()).jpg", completionHandler: {self.elementBackGroundImage.image = $0}, errorHandler: {print($0)})
        print(elementBackGroundImage.alpha)
        print(elementBackGroundImage)
        if elementBackGroundImage.alpha == 1{
            self.elementTitle.textColor = UIColor.green
            self.ElementSymbol.textColor = UIColor.white
            elementBackGroundImage.alpha = 0.75
        }
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
