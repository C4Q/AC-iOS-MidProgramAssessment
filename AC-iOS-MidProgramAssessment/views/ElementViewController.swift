//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    
    @IBOutlet weak var elementTableView: UITableView!
    
    
    var elements = [Element]() {
        didSet {
            self.elementTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.elementTableView.dataSource = self
        self.elementTableView.delegate = self
      
        
    }

    func loadData() {
        let setElements = {(onlineElements: [Element]) in
            self.elements = onlineElements
         
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ElementAPICLient.manager.getElement(completionHandler: setElements, errorHandler: printErrors)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.elementTableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as! ElementTableViewCell
        let thisElement = self.elements[indexPath.row]
        cell.elementNameLabel.text = thisElement.name
        cell.symbolAtomicWeightLabel.text = thisElement.symbol + " " + "(\(thisElement.number))" + " " + thisElement.weight.description
        cell.elementImageView.image = nil
        
        let imageUrl = "http://www.theodoregray.com/periodictable/Tiles/\(thisElement.urlNumber)/s7.JPG"
        let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.elementImageView.image = onlineImage
            cell.setNeedsLayout()
        }
         ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: getImage, errorHandler: {print($0)})
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationDVC = segue.destination as? ElementDetailViewController {
            let selectedRow = elementTableView.indexPathForSelectedRow?.row
            let selectedElement = elements[selectedRow!]
            destinationDVC.anElement = selectedElement
            let bigImageUrl = destinationDVC.anElement.bigImageURL
            
            let getBigImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                destinationDVC.elementBigImage.image = onlineImage
                
            }
            ImageAPIClient.manager.getImage(from: bigImageUrl, completionHandler: getBigImage, errorHandler: {print($0)})
        }
    }
    
    
}

