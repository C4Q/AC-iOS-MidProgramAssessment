//
//  PeriodicTableElementsDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Clint Mejia on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class PeriodicTableElementsDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet var elementLabels: [UILabel]!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    var selectedElement: Elements?
    
    //MARK: ViewDidLoad override
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        loadImage()
    }
    
    //MARK: - Functions
    
            // tried to complete post
    
//    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
//        let user = "clint"
//        let favoriteElement = selectedElement?.name
//        let newfavorite = (name: user, favorite: favoriteElement)
//      ElementsAPIClient.manager.post(order: newfavorite){ print($0) }
//        return
//    }

    
    
    func loadImage() {
        elementImageView.image = nil
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let imageURLStr = selectedElement?.name.lowercased() ?? "carbon"
        let imageURL = "http://images-of-elements.com/\(imageURLStr).jpg"
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.elementImageView.image = onlineImage
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: {print($0)})
    }
    
    
    
    func setLabels() {
        for label in elementLabels {
            switch label.tag {
            case 0:
                label.text = (selectedElement?.number.description ?? "Unknown Element")
            case 1:
                label.text = selectedElement?.symbol
            case 2:
                label.text = selectedElement?.name
            case 3:
                label.text = (selectedElement?.weight.description ?? "Weight: N/A")
            case 4:
                let meltingC = selectedElement?.melting_c == nil ?  0 : selectedElement?.melting_c
                label.text = "Melting Point: " + (meltingC?.description)!
            case 5:
                let boilingC = selectedElement?.boiling_c == nil ? 0 : selectedElement?.boiling_c
                label.text = "Boiling Point: " + (boilingC?.description)!
            case 6:
                label.text = (selectedElement?.number.description ?? "Unknown Element")
            default:
                break
            }
        }
    }
    
}
