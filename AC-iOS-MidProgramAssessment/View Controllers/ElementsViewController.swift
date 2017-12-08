//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    @IBOutlet weak var elementsTableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            self.elementsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elementsTableView.delegate = self
        self.elementsTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = { (onlineElements: [Element]) in
            self.elements = onlineElements
        }
        ElementAPIClient.manager.getElements(from: urlStr, completionHandler: completion, errorHandler: { print($0) })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController {
            guard let indexPathselected = elementsTableView.indexPathForSelectedRow else { return }
            let selectedElement = self.elements[indexPathselected.row]
            destination.element = selectedElement
        }
    }

}

extension ElementsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementCell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath)
        let selectedElement = self.elements[indexPath.row]
        if let elementCell = elementCell as? CustomElementTableViewCell {
            elementCell.thumbnailSpinner.isHidden = false
            elementCell.thumbnailSpinner.startAnimating()
            elementCell.elementNameLabel.text = selectedElement.name
            elementCell.elementInfoLabel.text =  "\(selectedElement.symbol)(\(selectedElement.number)) \(selectedElement.weight)"
            let elemImageURLStr = "http://www.theodoregray.com/periodictable/Tiles/\(formatElementID(elementID: selectedElement.id))/s7.JPG"
            elementCell.elementImage.image = nil
            let completionImage: (UIImage) -> Void = { (onlineShowImage: UIImage) in
                elementCell.elementImage.image = onlineShowImage
                elementCell.setNeedsLayout()
                elementCell.thumbnailSpinner.stopAnimating()
                elementCell.thumbnailSpinner.isHidden = true
            }
            ImageAPIClient.manager.getImage(from: elemImageURLStr, completionHandler: completionImage, errorHandler: { print($0) })
        }
        return elementCell
    }
    
    func formatElementID(elementID: Int) -> String {
        let result: Double = Double(elementID)/100.0
        if result >= 1 { return "\(elementID)" }
        else if result < 1 && result >= 0.1 { return "0\(elementID)" }
        else { return "00\(elementID)" }
    }

}
