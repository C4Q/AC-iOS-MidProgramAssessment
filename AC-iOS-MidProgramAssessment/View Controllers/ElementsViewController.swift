//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    @IBOutlet weak var elementsTableView: UITableView!
    
    
    var elements = [Element]() {
        didSet {
            self.elementsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elementsTableView.delegate = self
        self.elementsTableView.dataSource = self
        getElementsData()
    }
    
    func getElementsData() {
        let str = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = {(onlineShows: [Element]) in
            self.elements = onlineShows
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        ElementsAPIClient.manager.getElements(from: str, completionHandler: completion, errorHandler: errorHandler)
    }
}
