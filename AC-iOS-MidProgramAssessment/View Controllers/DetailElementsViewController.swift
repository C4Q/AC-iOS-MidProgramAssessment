//
//  DetailElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailElementsViewController: UIViewController {
    
    //set outlets
    @IBOutlet weak var detailedElementImage: UIImageView!
    @IBOutlet weak var atomicNumberLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var discoveryYearLabel: UILabel!
    @IBOutlet weak var addToFavoritesBtn: UIButton!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    //what's powering this VC. NOT SET YET
    var detailElement: PeriodicElement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //make sure you have a detailed element
        guard let detailElement = detailElement else {return}
        activitySpinner.isHidden = true
        setUpUI()
        setImage()
    }
    
    //post
    @IBAction func POSTButtonPressed(_ sender: UIButton) {}
    
    func setUpUI(){
        atomicNumberLabel.text = "\(String(describing: detailElement.number))" //number
        symbolLabel.text = "\(String(describing: detailElement.symbol))" //symbol
        print(detailElement.symbol)
        nameLabel.text = "\(String(describing: detailElement.name))"//name
        print(detailElement.name)
        weightLabel.text = "\(String(describing: detailElement.weight))"//weight
        print(detailElement.weight)
        
        //unwrapped optionals
        if detailElement.boilingPoint != nil{
            boilingPointLabel.text = "Boiling Point: \(String(describing: detailElement.boilingPoint!))" //boilingPoint
            print(detailElement.boilingPoint!)
        } else {
            boilingPointLabel.text = "Boiling Point: Not Known"
        }
        
        if detailElement.meltingPoint != nil {
            meltingPointLabel.text = "Melting Point: \(String(describing: detailElement.meltingPoint!))" //meltingPoint
            print(detailElement.meltingPoint!)
        } else {
            meltingPointLabel.text = "Melting Point: Not Known"
        }
        //discoveryYearLabel.text = "\(String(describing: detailElement.discoveryYear))"
    }
    func setImage(){
        if let imageUrlStr = detailElement.largeImage{
            activitySpinner.isHidden = false
            activitySpinner.startAnimating()
            
            //set completion
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.detailedElementImage.image = onlineImage
                print("Just set image")
                self.activitySpinner.isHidden = true
                self.activitySpinner.stopAnimating()
            }
            //call ImageAPIClient
            ImageAPIClient.manager.getImage(from: imageUrlStr,
                                            completionHandler: completion,
                                            errorHandler: {print($0)})
        }else{
            self.detailedElementImage.image = #imageLiteral(resourceName: "noImg")
        }
        detailedElementImage.layer.borderWidth = 10
        detailedElementImage.layer.borderColor = UIColor.black.cgColor
    }
}




