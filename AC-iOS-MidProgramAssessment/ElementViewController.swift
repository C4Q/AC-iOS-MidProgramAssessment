//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var elements = [Element]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
       loadData()
    }
    func loadData() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = {(onlineElement: [Element]) in
            self.elements = onlineElement
        }
        ElementAPIClient.manager.getElement(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
  


}
extension ElementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "element cell", for:indexPath)
        let theElement = elements[indexPath.row]
        if let cell = cell as? ElementTableViewCell {
       cell.nameLabel.text = theElement.name
        cell.numberLabel.text = "\(theElement.symbol)(\(theElement.number)) \(theElement.weight)"
          var numStr = String(theElement.number)
            switch numStr.count {
            case 1:
                numStr = "00\(theElement.number)"
            case 2:
                numStr = "0\(theElement.number)"
            default:
                numStr = "\(theElement.number)"
            }
        let imageStr = "http://www.theodoregray.com/periodictable/Tiles/\(numStr)/s7.JPG"
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                 cell.setNeedsLayout()
                cell.elementImageView.image = onlineImage
            }
            ElementImageAPIClient.manager.getImages(from: imageStr, completionHandler: completion, errorHandler: {print($0)})
            
           return cell
        }
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController {
            destination.element = elements[tableView.indexPathForSelectedRow!.row]
        }
    }
}
