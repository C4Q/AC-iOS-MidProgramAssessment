//
//  FavoritesViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

//TODO: - complete Favorites tableView to show students favorite elements from fieldbook website

class FavoritesViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var favoriteImages = [Favorites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.favoritesTableView.dataSource = self
//        self.favoritesTableView.delegate = self
        self.refreshControl.addTarget(self, action: #selector(refreshOrders(_:)), for: UIControlEvents.valueChanged)
        favoritesTableView.refreshControl = refreshControl
        getImageData()
    }
    
    @objc private func refreshOrders(_ sender: Any) {
        getImageData()
    }
    
    //TODO: - get image data
    func getImageData() {}
    
}

//extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return favoriteImages.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritesTableViewCell else {return UITableViewCell()}
//        let oneFavorite = favoriteImages[indexPath.row]
//
//        cell.nameLabel.text = "Student: \(oneFavorite.name ?? "They who shall not be named...")"
//        cell.symbolNumberAtomWeightLabel.text = "Favorite Element: \(oneFavorite.favoriteElement ?? "Unknown")"
//        cell.elementImageView.image = #imageLiteral(resourceName: "molecule")
//        cell.spinner.isHidden = false
//        cell.spinner.startAnimating()
//
//        let bigImageUrl = oneFavorite.favoriteElement
//        print(bigImageUrl)
//        let getTheImage: (UIImage) -> Void = {(onlineImage: UIImage) in
//            cell.elementImageView.image = onlineImage
//            cell.spinner.isHidden = true
//            cell.spinner.stopAnimating()
//        }
//
//        ImageAPIClient.manager.getImage(from: bigImageUrl, completionHandler: getTheImage, errorHandler: {print($0)})
//    }
//    return cell
//}


