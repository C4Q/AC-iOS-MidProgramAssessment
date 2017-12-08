//
//  FavoriteElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class FavoriteElementsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Favorites]()
    
    private let refreshControl = UIRefreshControl()
    
    @objc private func refreshOrders(_ sender: Any) {
        loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(refreshOrders(_:)), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        loadFavorites()
    }

    func loadFavorites() {
        let getFavoriteElements = {(onlineElements: [Favorites]) in
            self.favorites = onlineElements
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ElementsAPIClient.manager.getFavorites(completionHandler: getFavoriteElements, errorHandler: printErrors)
    }
    
}


extension FavoriteElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorite Cells", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.name
        cell.detailTextLabel?.text = favorite.favorite_element
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
}
