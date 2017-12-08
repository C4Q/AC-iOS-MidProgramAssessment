//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var elements = [Element]() {
        didSet {
            self.tableView.reloadData()
            //loads the tableView data
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.rowHeight = 140
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadData() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = {(onlineElement: [Element]) in
            self.elements = onlineElement
        }
    ElementAPIClient.manager.getElements(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element cell", for: indexPath)
        if let cell = cell as? ElementCellTableViewController {
            cell.nameLabel.text = element.name
            cell.symbolInfoLabel.text = "\(element.symbol)((\(element.number)) \(element.weight)"
            let urlId = element.id
            var finalUrlId = ""
            if urlId < 9{
                finalUrlId = "00\(urlId)"

            } else if urlId > 9 {
                finalUrlId = "0\(urlId)"
            } else {
                finalUrlId = "\(urlId)"
            }
            let imageUrl = "http://www.theodoregray.com/periodictable/Tiles/\(finalUrlId)/s7.JPG"
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.imgView.image = nil
                cell.imgView.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: completion, errorHandler: {print($0)})
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let element = elements[tableView.indexPathForSelectedRow!.row]
        if let EVC = segue.destination as? ElementDetailViewController {
            EVC.element = element
        }
    }
}


