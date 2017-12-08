//
//  PeriodicTableElementsViewControllerExtension.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Clint Mejia on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

extension PeriodicTableElementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodicElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedElement = periodicElements[indexPath.row]
        guard let cell = periodicTableView.dequeueReusableCell(withIdentifier: "periodicElementCell", for: indexPath) as? PeriodicTableElementCustomTableViewCell else {
            return UITableViewCell()
        }
        cell.elementNameLabel.text = selectedElement.name
        cell.elementSymbolLabel.text = "\(selectedElement.symbol)(\(selectedElement.number)) \(selectedElement.weight)"
        cell.elementImageView.image = nil
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        let imageURL = selectedElement.thumbnailImageUrl
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.elementImageView.image = onlineImage
            cell.setNeedsLayout()
            DispatchQueue.main.async {
                cell.activityIndicator.isHidden = true
                cell.activityIndicator.stopAnimating()
            }
        }
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: {print($0)})
        return cell
    }
    
}
