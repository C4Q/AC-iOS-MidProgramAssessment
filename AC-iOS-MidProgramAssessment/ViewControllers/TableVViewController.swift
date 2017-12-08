//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TableVViewController: UIViewController {
    
    var elements =  [Element]() {
        didSet {
            dump(elements)
           self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Periodic Table of Elements"
        loadElements()
    }
    
    func loadElements() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = {(onlineElements: [Element]) in
            self.elements = onlineElements
            dump(onlineElements)

        }
        ElementAPI.manager.getElement(from: urlStr,
                                      completionHandler: completion,
                                      errorHandler: {print($0)})
    }
    
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationDVC = segue.destination as? DetailViewController {
            destinationDVC.element = elements[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}

extension TableVViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        if let cell = cell as? ElementTableViewCell {
            cell.nameLabel.text = element.name
            cell.elementInfoLabel.text = "\(element.symbol ?? "None") (\(element.number?.description ?? "None")) \(element.weight?.description ?? "None")"
            cell.elementImageView?.image = nil
            cell.spinner.isHidden = false
            cell.spinner.stopAnimating()
            
            let idNum = element.id
            var newID: String = element.id.description
                switch idNum {
                case 0..<10 :
                    newID = "00\(idNum)"
                case 10..<100:
                    newID = "0\(idNum)"
                case 100..<1000:
                    newID = "\(idNum)"
                default:
                    ""
                }
                print(newID)
            
            

            
            let imageStr = "http://www.theodoregray.com/periodictable/Tiles/\(newID)/s7.JPG"
            let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.elementImageView?.image = onlineImage
                cell.setNeedsLayout() // indicates that view needs to be redrawn
            }
            ImageAPIClient.manager.getImage(from: imageStr, completionHandler: setImage, errorHandler: {print($0)})
        }

        
        return cell
    }
}
