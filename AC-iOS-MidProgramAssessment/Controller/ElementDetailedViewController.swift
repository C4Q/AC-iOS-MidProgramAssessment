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
	var element: Element!

	//MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
			loadData()
    }

	func loadData(){
		navigationItem.title = element.name
		elementNameLabel?.text = element.name
		elementSymbolLabel?.text = element.symbol
		elementNameLabel?.text = element.name
		elementWeightLabel?.text = "\(element.weight)"
		elementMeltingPointLabel?.text = "\(element.meltingPoint)"
		elementBoilingPointLabel?.text = "\(element.boilingPoint)"
		if element.number < 90 {
			loadImage()
		}
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
		let newFavorite = Favorite(name: "Winston", favoriteElement: element.name)
		FavoriteAPIClient.manager.post(favorite: newFavorite, errorHandler: { print($0) })
	}

//Second POST method - standalone
	@IBAction func postButtonPressed2(_ sender: Any) {
		let parameters = ["name”: “Winston”, “favoriteElement”: “\(element.name)"]
		guard let url = URL(string: "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites") else {return}
		var request = URLRequest(url: url)
		let userName = "key-1"
		let password = "ptJP0XOFIQ_xysF7nwoB"
		let nameAndPassStr = "\(userName):\(password)"
		let nameAndPassData = nameAndPassStr.data(using: .utf8)!
		let authBase64Str = nameAndPassData.base64EncodedString()
		let authStr = "Basic \(authBase64Str)"
		request.addValue(authStr, forHTTPHeaderField: "Authorization")
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
		request.httpBody = httpBody
		let session = URLSession.shared
		session.dataTask(with: request) { (data, response, error) in
			if let response = response { print(response) }
			if let data = data {
				do {
					let json = try JSONSerialization.jsonObject(with: data, options: [])
					print(json)
				}
				catch {print(error)}
			}
			}.resume()
	}
}


