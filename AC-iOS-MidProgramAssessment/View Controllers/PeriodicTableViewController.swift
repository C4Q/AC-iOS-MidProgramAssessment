//
//  PeriodicTableViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
//Note: Cells are working! There is just no selection color because it looked terrible with color scheme!

class PeriodicTableViewController: UIViewController {
    
    @IBOutlet weak var elementsTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var periodicTable = [Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsTableView.dataSource = self
        self.navigationItem.title = "Periodic Table"
        loadData()
        self.refreshControl.addTarget(self, action: #selector(refreshPeriodicTable), for: UIControlEvents.valueChanged)
        elementsTableView.refreshControl = refreshControl
    }
    
    @objc private func refreshPeriodicTable(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = { (onlineElements: [Element]) in
            self.periodicTable = onlineElements
            self.elementsTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            print(error)
            self.refreshControl.endRefreshing()
        }
        PeriodicTableAPIClient.manager.getElements(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
    }
    
    func turnElementNumToThreeDigitString(from num: Int) -> String {
        let numAsStr = num.description
        switch num {
        case _ where numAsStr.count == 1:
            return "00\(numAsStr)"
        case _ where numAsStr.count == 2:
            return "0\(numAsStr)"
        case _ where numAsStr.count == 3:
            return numAsStr
        default:
            return numAsStr
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementViewController {
            destination.element = periodicTable[elementsTableView.indexPathForSelectedRow!.row]
        }
    }
    
}

extension PeriodicTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodicTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = periodicTable[indexPath.row]
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: "PTCell", for: indexPath)
        if let cell = cell as? PeriodicTableViewCell {
            cell.nameLabel?.text = element.name
            cell.atomicWeightLabel?.text = element.weight.description
            
            cell.elementImageView.image = nil
            cell.elementActivityIndicator.startAnimating()
            guard let url = URL(string: "http://www.theodoregray.com/periodictable/Tiles/\(turnElementNumToThreeDigitString(from: element.number))/s7.JPG") else { print("problem with url"); return cell }
            DispatchQueue.main.async { 
                guard let rawImageData = try? Data(contentsOf: url) else { print("problem with conversion to data"); return }
                DispatchQueue.main.async {
                    guard let onlineImage = UIImage(data: rawImageData) else { return }
                    cell.elementImageView.image = onlineImage
                    cell.elementActivityIndicator.stopAnimating()
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
}




