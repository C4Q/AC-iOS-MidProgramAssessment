//
//  PeriodicTableViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PeriodicTableViewController: UITableViewController {
    var elements: [Element]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jsonUrl = URL(string: NetworkPath.jsonGetAddress) else { return }
        
        APIRequestManager.shared.getData(from: jsonUrl) { (data: Data?) in
            if let validData = data,
                let array = APIRequestManager.shared.grabElements(from: validData) {
                self.elements = array
                
                DispatchQueue.main.async {
                    self.tableView!.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.elementCell, for: indexPath) as! ElementTableViewCell
        let element = self.elements?[indexPath.row]
        
        guard let name = element?.name, let symbol = element?.symbol, let number = element?.number, let weight = element?.weight else {
            cell.name.text = "N/A"
            cell.additionalDetails.text = ""
            
            return cell
        }
        
        cell.name.text = name
        cell.additionalDetails.text = "\(String(describing: symbol))(\(String(describing: number))) \(String(describing: weight))"
        
        // get pics
        
        guard let imageUrl = element?.thumbnailURL else { return cell }
        
        APIRequestManager.shared.getData(from: imageUrl) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    if tableView.cellForRow(at: indexPath) != nil {
                        cell.pic.image = validImage
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Identifier.segueToDetail else { return }
        
        let nextVC = segue.destination as! ElementDetailViewController
        let cell = sender as? UITableViewCell
        
        guard let indexPath = tableView.indexPath(for: cell!) else { return }
        
        let chosenElement = self.elements![indexPath.row]
        
        nextVC.chosenElement = chosenElement
        nextVC.title = chosenElement.name
    }

}
