//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
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
        loadData()
    }
    
    func loadData() {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([Element]) -> Void = { (onlineElements: [Element]) in
            self.elements = onlineElements
        }
        ElementAPIClient.manager.getElements(from: urlStr, completionHandler: completion, errorHandler: { print($0) })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ElementsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementCell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath)
        let selectedElement = self.elements[indexPath.row]
        elementCell.textLabel?.text = selectedElement.name
        elementCell.detailTextLabel?.text = selectedElement.id.description
        return elementCell
    }

}
