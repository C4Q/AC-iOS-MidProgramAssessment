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
    
    @IBAction func favourite(_ sender: UIButton) {
        guard let element = element else {
            return
        }
        let myFavourite = Favourite(name: "Yaseen", favouriteElement: "\(element.name)")
        FavouriteAPIClient.manager.post(favourite: myFavourite, errorHandler: {print($0)})
        
    }
    
    
    
    
    
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

    }
    override func viewWillLayoutSubviews() {
        if let element = element{
        ImageAPIClient.manager.getImage(from: "http://images-of-elements.com/\(element.name.lowercased()).jpg", completionHandler: {self.elementBackGroundImage.image = $0}, errorHandler: {print($0)})
        print(elementBackGroundImage.alpha)
        if elementBackGroundImage.alpha == 1{
            self.elementTitle.textColor = UIColor.white
            self.ElementSymbol.textColor = UIColor.white
            self.discoverYear.textColor = UIColor.white
            self.elementWeight.textColor = UIColor.white
            self.elementBoilingPoint.textColor = UIColor.white
            self.elementMeltingPoint.textColor = UIColor.white
            self.elementNumber.textColor = UIColor.white
            elementBackGroundImage.alpha = 0.85
        }
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
