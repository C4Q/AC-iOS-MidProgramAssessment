//
//  PeriodicTableElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Clint Mejia on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class PeriodicTableElementsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var periodicTableView: UITableView!
    
    //MARK: - Variables
    var periodicElements = [Elements](){
        didSet {  //contacts.foreach{print($0)}
            self.periodicTableView.reloadData()
        }
    }
    
    //MARK: - ViewDidLoad override
    override func viewDidLoad() {
        super.viewDidLoad()
        periodicTableView.delegate = self
        periodicTableView.dataSource = self
        loadData()
        print(periodicElements)
    }
    
    //MARK: - Functions
    func loadData() {
        let url = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Elements]) -> Void = { (onlineElements: [Elements]) in
            self.periodicElements = onlineElements
        }
        ElementsAPIClient.manager.getElements(from: url, completionHandler: completion, errorHandler: { print($0) })
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PeriodicTableElementsDetailViewController {
            let selectedElement = periodicElements[(periodicTableView.indexPathForSelectedRow?.row)!]
            destination.selectedElement = selectedElement
        }
    }
    
}



