//
//  ElementsTableViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {
    
    var elementsArr = [Element]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        loadData()
        self.tableView.rowHeight = 100
    }
    
    
    func loadData() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let setElementsToOnlineElements: ([Element]) -> Void = {(onlineElements: [Element]) in
            self.elementsArr = onlineElements
        }
        ElementAPIClient.manager.getElements(from: urlStr,
                                        completionHandler:setElementsToOnlineElements,
                                        errorHandler: {print($0)})
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementChosen = elementsArr[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as! ElementTableViewCell
        
        //set labels
        cell.elementNameLabel.text = elementChosen.name
        cell.symbolAndWeightLabel.text = "\(elementChosen.symbol) \(elementChosen.weight)"
        //cell.elementThumbnail.image = nil
        
        func loadMyImage() {
            var urlStr = ""
            if elementChosen.number <= 9 {
            urlStr = "http://www.theodoregray.com/periodictable/Tiles/00\(elementChosen.number)/s7.JPG"
            } else {
            urlStr = "http://www.theodoregray.com/periodictable/Tiles/0\(elementChosen.number)/s7.JPG"
            }
            let setElementsToOnlineElements: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.elementThumbnail.image = onlineImage
            }
            ImageAPIClient.manager.getImage(from: urlStr,
                                            completionHandler:setElementsToOnlineElements,
                                            errorHandler: {print($0)})
        }
        loadMyImage()
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController {
            let selectedElement = elementsArr[self.tableView.indexPathForSelectedRow!.row]
            destination.elementPassed = selectedElement
        }
    }
}
