//
//  FieldBookViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class FieldBookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    var favorites = [FieldBook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.refreshControl.addTarget(self, action: #selector(refreshOrders(_:)), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        loadData()
        
    }
    
    @objc private func refreshOrders(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        FieldBookAPIClient.manager.getFieldbookImagesArray(completionHander: { (fieldbooks) in
            self.favorites = fieldbooks
            self.tableView.reloadData()
        }, errorHandler: {print($0)})
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        let aFavorite = favorites[indexPath.row]
        
        cell.nameLabel
        cell.favoriteByInsertNameHereLabel.text = "\(aFavorite.student_name)"
        
        //Insert IMAGE API HERE
        if let urlStr = aFavorite.image_link {
            cell.spinner.isHidden = false
            cell.spinner.startAnimating()
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.imageViewInCell.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr,
                                            completionHandler: setImageToOnlineImage,
                                            errorHandler: {print($0)})
            //cell.spinner.stopAnimating()
            //cell.spinner.isHidden = true
            
        } else {
            //cell.spinner.isHidden = true
            //cell.imageViewInCell.image = nil
        }
        
        return cell
    }
    
}

