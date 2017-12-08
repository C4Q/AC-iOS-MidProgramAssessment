//
//  DetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Caroline Cruz on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var element: Element!
    
    
    @IBOutlet weak var myNameTF: UITextField!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var mPLabel: UILabel!
    @IBOutlet weak var bPLabel: UILabel!
    @IBOutlet weak var dYLabel: UILabel!
    @IBOutlet weak var elementIV: UIImageView!
    
    
    @IBAction func favButtonPressed(_ sender: Any) {
        guard let myName = self.myNameTF.text else {
            //            Display message to put order name
            return
        }
        
        print(myName, element.name)
        self.myNameTF.text = ""
        //Make POST request with orderName and orderCost
        let postFav = FavElement(name: myName, favorite_element: element.name)
        FavoriteAPIClient.manager.post(fav: postFav){ print($0) }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = element.name
        loadData()
        
    }
    
    func loadData() {
        symbolLabel.text = "Symbol: \(element.symbol ?? "Unknown")"
        numberLabel.text = "Number: \(element.number?.description ?? "Unknown")"
        weightLabel.text = "Weight: \(element.weight?.description ?? "Unknown")"
        mPLabel.text = "Melting Point: \(element.meltingPoint?.description ?? "Unknown")"
        bPLabel.text = "Boiling Point: \(element.boilingPoint?.description ?? "Unknown")"
        
        let imageStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementIV?.image = onlineImage
            self.elementIV.setNeedsLayout() // indicates that view needs to be redrawn
        }
        ImageAPIClient.manager.getImage(from: imageStr, completionHandler: setImage, errorHandler: {print($0)})
    }

}
