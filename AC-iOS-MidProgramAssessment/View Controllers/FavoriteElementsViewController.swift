//
//  FavoriteElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class FavoriteElementsViewController: UIViewController {
    
    @IBOutlet weak var favoriteElementsTableView: UITableView!
    
    var favoriteElements: [FavoriteElement] = []
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        favoriteElementsTableView.dataSource = self
        
        favoriteElementsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
    }
    
    @objc func refreshList(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        FavoriteElementAPIClient.manager.getFavoriteElements(
            completionHandler: { (onlineFavoriteElements) in
                self.favoriteElements = onlineFavoriteElements
                self.favoriteElementsTableView.reloadData()
        },
            errorHandler: {print($0)})
        refreshControl.endRefreshing()
    }
}

//Table View Methods
extension FavoriteElementsViewController: UITableViewDataSource {
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteElementCell", for: indexPath)
        let currentElement = favoriteElements[indexPath.row]
        
        cell.textLabel?.text = currentElement.favoriteElement
        cell.detailTextLabel?.text = currentElement.name
        
        return cell
    }
}
