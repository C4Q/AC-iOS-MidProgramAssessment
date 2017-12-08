//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var allElements = [ElementsClass]()
    
    @objc private func refreshElements(_ sender: Any) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.refreshControl.addTarget(self, action: #selector(refreshElements), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        loadData()
    }
    func loadData() {
        let urlStr = ElementsClass.apiEndPoint
        let setElementsToOnlineElements = {(onlineElements: [ElementsClass]) in
            self.allElements = onlineElements
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        let printErrors = {(error: Error) in
            print(error)
            self.refreshControl.endRefreshing()
        }
        ElementsAPIClient.manager.getElementsArray(from: urlStr, completionHandler: setElementsToOnlineElements, errorHandler: printErrors)
    }
    
    //MARK: TableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        let anElement = allElements[indexPath.row]
        
        configureCell(cell: cell, element: anElement)
        
        return cell
    }
    
    func configureCell(cell: CustomTableViewCell, element: ElementsClass) {
        cell.spinner.startAnimating()
        cell.spinner.isHidden = false
        cell.nameLabel.text = element.name
        cell.symbolNumberAtomWeightLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
        
        let urlStr = element.thumbnailLink
        let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.elementImageView.image = onlineImage
            cell.setNeedsLayout()
            cell.spinner.isHidden = true
            cell.spinner.stopAnimating()
        }
        ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setImageToOnlineImage, errorHandler: {print($0)})
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedViewController {
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            let selectedElement = self.allElements[selectedRow]
            destination.aSeguedElement = selectedElement
        }
    }
    
    
}
