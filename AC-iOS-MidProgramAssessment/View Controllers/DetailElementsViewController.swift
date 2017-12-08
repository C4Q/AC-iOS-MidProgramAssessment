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
    var detailElement: PeriodicElement? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpUI()
        //activitySpinner.isHidden = true
        //make sure you have a detailed element
        guard let detailElement = detailElement else {return}
        
        //setImage()
        
        func setUpUI(){
            
            if detailElement.number != nil {
                atomicNumberLabel.text = "\(String(describing: detailElement.number))"
            } else {
                atomicNumberLabel.text = "X"
            }
            
            symbolLabel.text = "\(String(describing: detailElement.symbol))"
            nameLabel.text = "\(String(describing: detailElement.name))"
            weightLabel.text = "\(String(describing: detailElement.weight))"
            boilingPointLabel.text = "\(String(describing: detailElement.boilingPoint))"
            meltingPointLabel.text = "\(String(describing: detailElement.meltingPoint))"
            discoveryYearLabel.text = "\(String(describing: detailElement.discoveryYear))"
        }
        
        func setImage(){
            //        if let imageUrlStr = detailEpisodes.image?.original {
            //            activitySpinner.isHidden = false
            //            activitySpinner.startAnimating()
            //            //set completion
            //            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            //                self.EpisodeImage.image = onlineImage
            //                print("Just set image")
            //                self.activitySpinner.isHidden = true
            //                self.activitySpinner.stopAnimating()
            //            }
            //            //call ImageAPIClient
            //            ImageAPI.manager.loadImage(from: imageUrlStr,
            //                                       completionHandler: completion,
            //                                       errorHandler: {print($0)})
            //        }else{
            //            self.EpisodeImage.image = #imageLiteral(resourceName: "defaultImage")
            //        }
            //        EpisodeImage.layer.borderWidth = 10
            //        EpisodeImage.layer.borderColor = UIColor.black.cgColor
            //    }
        }
    }
    @IBAction func POSTButtonPressed(_ sender: UIButton) {}
    
}
