//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementController: UIViewController {

    var elements: [Element]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func sortByNamePressed(_ sender: Any) {
        elements = elements?.sorted{$0.name < $1.name}
    }
    
    @IBAction func sortByAtomicNumberPressed(_ sender: Any) {
        elements = elements?.sorted{$0.id < $1.id}
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let destination = segue.destination as! DetailController
            let touchedCell = sender as! ElementCell
            let index = tableView.indexPath(for: touchedCell)!.row
            destination.element = elements?[index]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ElementAPIClient.manager.getElements(from: Element.endpoint,
                                             completionHandler: {self.elements = $0},
                                             errorHandler: {print($0)})
    }

}

// MARK: Table View Data Source
extension ElementController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements?.count ?? 0
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementCell
        cell.elementImage.image = nil
        
        let index = indexPath.row
        guard let currentElement = elements?[index] else { return cell }
        
        cell.nameLabel.text = currentElement.name
        cell.detailLabel.text = currentElement.id.description
        
//        Grab Images
        let completion: (Data) -> Void = {
            cell.elementImage.image = UIImage(data: $0)
            cell.setNeedsLayout()
        }
        
        let errorHandler: () -> Void = {
            print(currentElement.smallImageEndpoint)
        }
        
        ImageDownloader.manager.getImage(from: currentElement.smallImageEndpoint,
                                         completionHandler: completion,
                                         errorHandler: errorHandler)
        
        return cell
    }
    
}
