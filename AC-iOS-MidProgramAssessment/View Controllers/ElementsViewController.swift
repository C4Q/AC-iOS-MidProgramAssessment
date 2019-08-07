//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadData()
    }
    
    func loadData(){
        let completion = {(onlineElements: [Element]) in
            self.elements = onlineElements
            self.tableView.reloadData()
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ElementAPIClient.manager.getElements(completionHandler: completion, errorHandler: printErrors)
    }
}











extension ElementsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath)
        let elementToSet = elements[indexPath.row]
        
        if let cell = cell as? ElementsTableViewCell{
            cell.elementName.text = elementToSet.name
            cell.elementDetails.text = elementToSet.symbol + "(\(elementToSet.number))" + "  " + elementToSet.weight.description
            
            var threeDigitElementNumber = ""
            
            switch elementToSet.id.description.count{
                
            case 1:
             threeDigitElementNumber = "00" + elementToSet.id.description
            case 2:
                threeDigitElementNumber = "0" + elementToSet.id.description
            case 3:
                threeDigitElementNumber = elementToSet.id.description
            default:
                threeDigitElementNumber = ""
                
            }
            let urlStr = "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitElementNumber)/s7.JPG"
            
            
            
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.elementPicture.image = onlineImage
                cell.setNeedsLayout()

            }
            
            
            ImageAPIClient.manager.getImage(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
            
            
            return cell
        }
        return cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ElementDetailViewController{
            let selectedElement = elements[(tableView.indexPathForSelectedRow?.row)!]
            destination.element = selectedElement
        }
    }
    
    
    
}
