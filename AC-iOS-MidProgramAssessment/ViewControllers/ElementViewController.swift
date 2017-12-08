//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    var elements = [Element]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.tableView.rowHeight = 140;
        loadElements()
    }

    func loadElements() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        ElementAPIClient.manager.getElements(from: urlStr, completionHandler: {self.elements = $0}, errorHandler: {print($0)})
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController {
            let elementAtRow = elements[tableView.indexPathForSelectedRow!.row]
            destination.selectedElement = elementAtRow
        }
    }

}
extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        guard let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementTableViewCell else {return UITableViewCell()}
        elementCell.nameLabel.text = element.name
        elementCell.numberLabel.text = "\(element.symbol)(\(element.id ?? 0)) \(element.weight)"
        guard let id = element.id else {
            return elementCell
        }
        var string = ""
        if id.description.count < 2 {
            string = "00\(id)"
        } else if id.description.count == 2 {
            string = "0\(id)"
        } 
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(string)/s7.JPG"
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: {elementCell.elementImageView.image = $0}, errorHandler: {print($0)})
        return elementCell
    }
}
