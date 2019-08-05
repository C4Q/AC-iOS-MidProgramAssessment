//
//  ElementsViewController+Extension.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

extension ElementsViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: -TableView Datasource Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.elementsTableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as? ElementTableViewCell {
            let element = self.elements[indexPath.row]
            cell.nameLabel.text = element.name
            cell.symbolAtomicLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
            //MARK: ImageOnline
            cell.elementImageView.image = nil
            let imageStr = String(element.number)
            let urlStr = "http://www.theodoregray.com/periodictable/Tiles/\(strFormat(imageStr))/s7.JPG"
            let setImageCompletion: (UIImage) -> Void = {(imageFromOnline: UIImage) in
                cell.elementImageView.image = imageFromOnline
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setImageCompletion, errorHandler: {print($0)})
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let elementDVC = segue.destination as? DetailElementViewController {
            elementDVC.element = elements[self.elementsTableView.indexPathForSelectedRow!.row]
        }
    }
    
    func strFormat(_ str: String) -> String {
        if str.count == 3 {
            return str
        } else if str.count == 2 {
            return "0" + str
        } else {
            return "00" + str
        }
    }
}



