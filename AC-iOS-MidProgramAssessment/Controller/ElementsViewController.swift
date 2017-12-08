//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Winston Maragh on 12/8/17.
//  Copyright © 2017Winston Maragh. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	//MARK: Outlets
	@IBOutlet weak var tableView: UITableView!


	//MARK: View Ovverides
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
	}

	//MARK: Variables
	var elements = [Element]() {
		didSet {
			loadElements()
			self.tableView.reloadData()
		}
	}

	//MARK: Functions
	func loadElements(){
		let setElements = {(onlineElements: [Element]) in
			self.elements = onlineElements
		}
		let printErrors = {(error: Error) in print(error)}
		ElementAPIClient.manager.getElements(completionHandler: setElements, errorHandler: printErrors)
//		ElementAPIClient.manager.getElements(from: urlStr, completionHandler:setElements, errorHandler: printErrors)
	}

	//MARK: TableView
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.elements.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementTableViewCell else {return UITableViewCell()}
		let element = elements[indexPath.row]
		cell.elementNameLabel?.text = element.name
		cell.elementSymbolWeightLabel?.text = "\(element.symbol)(\(element.number)) \(element.weight)"
		//Image
		cell.elementImageView?.image = nil
		cell.imageSpinner.isHidden = false //show spinner while getting image
		cell.imageSpinner.startAnimating() //start animation while waiting on image
		let stringForNumber = String(format: "%03d", element.number)
		let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(stringForNumber)/s7.JPG"
		let setImage: (UIImage)-> Void = {(onlineImage: UIImage) in
			cell.elementImageView?.image = onlineImage
			cell.setNeedsLayout()
			DispatchQueue.main.async {
				cell.imageSpinner.isHidden = true
				cell.imageSpinner.stopAnimating()
			}
		}
		ImageAPIClient.manager.getImage(from: imageURL, completionHandler: setImage, errorHandler: {print($0)})
		return cell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}


	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? ElementDetailedViewController {
			let row = tableView.indexPathForSelectedRow!.row
			let selectedElement = elements[row]
			destination.element = selectedElement
		}
	}


}
