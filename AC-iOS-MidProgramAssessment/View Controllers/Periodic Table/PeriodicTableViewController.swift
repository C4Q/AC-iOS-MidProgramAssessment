//
//  PeriodicTableViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Marty Hernandez Avedon on 02/15/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PeriodicTableViewController: UITableViewController {
    var elements: [Element]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jsonUrl = URL(string: NetworkPath.jsonGetAddress) else { return }
        
        APIRequestManager.shared.getData(from: jsonUrl) { (data: Data?) in
            if let validData = data,
                let array = APIRequestManager.shared.grabElements(from: validData) {
                
                for element in array {
                    guard let thumbnailUrl = element.thumbnailURL else { return }
                    guard let fullsizeUrl = element.fullsizeURL else { return }
                    
                    APIRequestManager.shared.getData(from: fullsizeUrl) { (data: Data?) in
                        if  let validData = data,
                            let validImage = UIImage(data: validData) {
                            DispatchQueue.main.async {
                                element.fullsizePic = validImage
                            }
                        }
                    }
                    
                    APIRequestManager.shared.getData(from: thumbnailUrl) { (data: Data?) in
                        if  let validData = data,
                            let validImage = UIImage(data: validData) {
                            DispatchQueue.main.async {
                                element.thumbnailPic = validImage
                            }
                        }
                    }
                }
                
                self.elements = array
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
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.yellow
            cell.name.textColor = UIColor.black
            cell.additionalDetails.textColor = UIColor.black
        } else {
            cell.contentView.backgroundColor = UIColor.black
            cell.name.textColor = UIColor.yellow
            cell.additionalDetails.textColor = UIColor.yellow
        }
        
        guard let name = element?.name, let symbol = element?.symbol, let number = element?.number, let weight = element?.weight else {
            cell.name.text = "N/A"
            cell.additionalDetails.text = ""
            
            return cell
        }
        
        cell.pic.image = element?.thumbnailPic
        cell.name.text = name
        cell.additionalDetails.text = "\(String(describing: symbol))(\(String(describing: number))) \(String(describing: weight))"
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Identifier.segueToDetail else { return }
        
        let nextVC = segue.destination as! ElementDetailViewController
        let cell = sender as! UITableViewCell
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let chosenElement = self.elements![indexPath.row]
        
        nextVC.chosenElement = chosenElement
        nextVC.title = chosenElement.name
    }
    
}
