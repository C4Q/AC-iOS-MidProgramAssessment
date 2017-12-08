//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var elements = [Elements]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadElements()
    }

    func loadElements() {
        let setElements = {(onlineElements: [Elements]) in
            self.elements = onlineElements
            self.tableView.reloadData()
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ElementsAPIClient.manager.getElements(completionHandler: setElements,
                                              errorHandler: printErrors)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element Cells", for: indexPath)
        let element = elements[indexPath.row]
        if let cell = cell as? ElementCellTableViewCell {
            cell.nameLabel.text = element.name
            cell.detailLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
            let imageUrlStr = "http://www.theodoregray.com/periodictable/Tiles/\(String(format: "%03d", element.number))/s7.JPG"
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.elementImageView?.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr,
                                            completionHander: completion,
                                            errorHandler: {print($0)})
            cell.setNeedsLayout()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController {
            destination.element = elements[tableView.indexPathForSelectedRow!.row]
        }
    }
}
