//
//  ElementTableViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController {
            let selectedElement = elements[(tableView.indexPathForSelectedRow?.row)!]
            destination.element = selectedElement
        }
    }

}

extension ElementTableViewController {
    
    func loadData() {
        FieldBookAPIClient.manager.getElements(completionHandler: { self.elements = $0 }, errorHandler: { print($0) })
    }
    
}

extension ElementTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        let element = elements[indexPath.row]
        if let cell = cell as? CustomElementTableViewCell {
            cell.elementImageView.image = nil
            cell.spinner.isHidden = false
            cell.spinner.startAnimating()
            cell.elementNameLabel.text = element.name
            cell.elementAtomicNumberAndWeightLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
            let imgURL = "http://www.theodoregray.com/periodictable/Tiles/\(String(element.number).threeDigitIntString)/s7.JPG"
            let completion: (UIImage?) -> Void = { (onlineImage: UIImage?) in
                if let img = onlineImage {
                    cell.elementImageView.image = img
                } else {
                    cell.elementImageView.image = #imageLiteral(resourceName: "no-image")
                }
                cell.setNeedsLayout()
                DispatchQueue.main.async {
                    cell.spinner.isHidden = true
                    cell.spinner.stopAnimating()
                }
            }
                ImageAPIClient.manager.getImage(from: imgURL, completionHandler: completion, errorHandler: { print($0) })

        }
        return cell
    }
    
}
