//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func loadElements() {
        let setElementsToOnlineElements: ([Element]) -> Void = {(onlineElements: [Element]) in
            self.elements = onlineElements
        }
        ElementAPIClient.manager.getElements(completionHandler: setElementsToOnlineElements, errorHandler: {print($0)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        loadElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Detail Segue" else {return}
        guard let episodeDVC = segue.destination as? ElementDetailViewController else {return}
        guard let selectedCell = sender as? ElementTableViewCell else {return}
        let selectedElement = elements[tableView.indexPath(for: selectedCell)!.row]
        episodeDVC.selectedElement = selectedElement
    }
    
}

//MARK: - TableView Methods

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as! ElementTableViewCell
        let element = elements[indexPath.row]
        
        cell.nameLabel.text = element.name
        cell.infoLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
        cell.showSpinner.isHidden = false
        cell.showSpinner.startAnimating()
        cell.thumbnailImage.image = nil
        func elementNumIn3(str: String) -> String {
            var tempStr = str
            while tempStr.count < 3 {
                tempStr.insert("0", at: tempStr.startIndex)
                
            }
            return tempStr
        }
        let urlStr = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumIn3(str: String(element.number)))/s7.JPG"
        let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.thumbnailImage.image = onlineImage
            cell.showSpinner.isHidden = true
            cell.showSpinner.stopAnimating()
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setImageToOnlineImage, errorHandler: {
            cell.thumbnailImage.image = #imageLiteral(resourceName: "no-image")
            cell.showSpinner.isHidden = true
            cell.showSpinner.stopAnimating()
            cell.setNeedsLayout()
            print($0)
        })
        
        return cell
    }
}
