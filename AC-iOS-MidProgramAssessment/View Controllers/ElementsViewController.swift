//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
        
    var elements = [Element]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.reloadData()
        loadData()
    }
    
    func loadData() {
        let url = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        ElementAPIClient.manager.getElements(from: url, completionHandler: {self.elements = $0}, errorHandler: {print($0)})
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        guard let elementCell = tableView.dequeueReusableCell(withIdentifier: "Custom Element Cell", for: indexPath) as? CustomElementCell else {return UITableViewCell()}
//        guard element.element != nil else {return elementCell}
        elementCell.nameLabel.text = element.name
        elementCell.infoLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
        elementCell.thumbnailImageView.image = nil
        
        let howManyDigits = Array(element.number.description)
        var elementNumThreeDigits = ""
        switch howManyDigits.count {
        case 1:
            elementNumThreeDigits = "00\(element.number)"
        case 2:
            elementNumThreeDigits = "0\(element.number)"
        case 3:
            elementNumThreeDigits = "\(element.number)"
        default:
            break
        }
        let imageUrlStr: String = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumThreeDigits)/s7.JPG"
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            elementCell.thumbnailImageView.image = onlineImage
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        return elementCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
    
    
}

// load elements data from the internet
///https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements
// segue to an element's details
// set custom cell row height
// load images from the internet
/// Thumbnail (for table view): http://www.theodoregray.com/periodictable/Tiles/ElementNumberWithThreeDigits/s7.JPG
//Example: http://www.theodoregray.com/periodictable/Tiles/018/s7.JPG

