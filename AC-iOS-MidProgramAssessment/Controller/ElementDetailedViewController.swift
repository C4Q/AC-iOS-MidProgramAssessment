//  ElementDetailedViewController.swift
//  AC-iOS-MidProgramAssessment
//  Created by Winston Maragh on 12/8/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import UIKit

class ElementDetailedViewController: UIViewController {

	//MARK: Outlets
	@IBOutlet weak var elementNumberLabel: UILabel!
	@IBOutlet weak var elementSymbolLabel: UILabel!
	@IBOutlet weak var elementNameLabel: UILabel!
	@IBOutlet weak var elementWeightLabel: UILabel!
	@IBOutlet weak var elementMeltingPointLabel: UILabel!
	@IBOutlet weak var elementBoilingPointLabel: UILabel!
	@IBOutlet weak var elementImageView: UIImageView!
	@IBOutlet weak var imageSpinner: UIActivityIndicatorView!

	//MARK: Variables
	var element: Element! {
		didSet{
			loadData()
		}
	}

	//MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	func loadData(){
		navigationItem.title = element.name
		elementNameLabel?.text = element.name
		elementSymbolLabel?.text = element.symbol
		elementNameLabel?.text = element.name
		elementWeightLabel?.text = "\(element.weight)"
		elementMeltingPointLabel?.text = "\(element.meltingPoint)"
		elementBoilingPointLabel?.text = "\(element.boilingPoint)"
		loadImage()
	}

	func loadImage(){
		elementImageView.image = nil
		elementImageView?.image = nil
		imageSpinner.isHidden = false //show spinner while getting image
		imageSpinner.startAnimating() //start animation while waiting on image
		let imageURL = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
		let setImage: (UIImage)-> Void = {(onlineImage: UIImage) in
			self.elementImageView.image = onlineImage
			self.elementImageView.setNeedsLayout()
			DispatchQueue.main.async {
				self.imageSpinner.isHidden = true
				self.imageSpinner.stopAnimating()
			}
		}
		ImageAPIClient.manager.getImage(from: imageURL, completionHandler: setImage, errorHandler: {print($0)})
	}
	
	//MARK: Actions
	@IBAction func postButtonPressed(_ sender: Any) {
		let newFavorite = Element(name: "Winston", favorite_element: element.name)
		ElementAPIClient.manager.postElement(element: newFavorite, errorHandler: { print($0) })
	}


}
