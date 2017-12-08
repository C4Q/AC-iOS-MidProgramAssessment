//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit


class PeriodicTableViewController: UIViewController {
    
    @IBOutlet weak var periodicTableView: UITableView!
    
    var elements: [Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodicTableView.delegate = self
        periodicTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        ElementAPIClient.manager.getElements(
            completionHandler: { (onlineElements) in
                self.elements = onlineElements
                self.periodicTableView.reloadData()
        },
            errorHandler: { (appError) in
                let errorMessage: String
                
                switch appError {
                case .badStatusCode(let num):
                    errorMessage = "Bad Status Code: \(num)"
                case .badURL(let string):
                    errorMessage = "Bad URL:\n\(string)"
                case .couldNotParseJSON(let rawError):
                    errorMessage = "Could not parse JSON:\n\(rawError)"
                case .other(let rawError):
                    errorMessage = "\(rawError)"
                default:
                    errorMessage = appError.localizedDescription
                }
                
                let alertController = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                
        })
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //to do
    }

}

//Table View Methods
extension PeriodicTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //to do
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // to do - should stop network request when the cell is no longer on the table view
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        let currentElement = elements[indexPath.row]
        
        if let elementCell = cell as? ElementTableViewCell {
            
            let color: (red: CGFloat, green: CGFloat, blue: CGFloat) = BackgroundColor.forElement(group: currentElement.group, symbol: currentElement.symbol) ?? (1,1,1)
            let inverseColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = BackgroundColor.inverseForElement(group: currentElement.group, symbol: currentElement.symbol) ?? (0,0,0)
            
            elementCell.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)

            elementCell.elementNameLabel.text = currentElement.name
            elementCell.elementNameLabel.textColor = UIColor(red: inverseColor.red, green: inverseColor.green, blue: inverseColor.blue, alpha: 1)
            
            elementCell.elementInfoLabel.text = "\(currentElement.symbol)(\(currentElement.number)) \(currentElement.weight)"
            elementCell.elementInfoLabel.textColor = UIColor(red: inverseColor.red, green: inverseColor.green, blue: inverseColor.blue, alpha: 1)
            
            //setting image
            let elementNumber: String
            
            if currentElement.number.description.count == 1 {
                elementNumber = "00" + currentElement.number.description
            } else if currentElement.number.description.count == 2 {
                elementNumber = "0" + currentElement.number.description
            } else {
                elementNumber = currentElement.number.description
            }
            
            let urlString = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumber)/s7.JPG"
            
            ImageAPIClient.manager.getImages(
                from: urlString,
                completionHandler: { (onlineImage) in
                    elementCell.elementImageView.image = nil
                    elementCell.elementImageView.image = onlineImage
                    elementCell.setNeedsLayout()
            },
                errorHandler: { (appError) in
                    let errorMessage: String
                    
                    switch appError {
                    case .badStatusCode(let num):
                        errorMessage = "Bad Status Code: \(num)"
                    case .badImageURL(let string):
                        errorMessage = "Bad Image URL:\n\(string)"
                    case .other(let rawError):
                        errorMessage = "\(rawError)"
                    default:
                        errorMessage = appError.localizedDescription
                    }
                    
                    let alertController = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
            })
            
            return elementCell
        }
        
        return cell
    }
}
