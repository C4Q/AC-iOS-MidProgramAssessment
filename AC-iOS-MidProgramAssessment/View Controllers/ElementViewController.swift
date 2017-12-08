//
//  ElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Ashlee Krammer on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //Variables
    
    var elements: [Element]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //Load Elements
    func loadElements() {
        
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        
        let completion = {(onlineElements: [Element]) in
            self.elements = onlineElements
            self.tableView.reloadData()
        }
        
        
        let errorHanlder: (AppError) -> Void = {(error: AppError) in
            switch error{
            case .noInternetConnection:
                print("No internet connection")
            case .couldNotParseJSON:
                print("Could Not Parse")
            case .badStatusCode:
                print("Bad Status Code")
            case .badURL:
                print("Bad URL")
            case .invalidJSONResponse:
                print("Invalid JSON Response")
            case .noDataReceived:
                print("No Data Received")
            case .notAnImage:
                print("No Image Found")
            default:
                print("Other error")
            }
        }
        
        ElementAPIClient.manager.getElements(from: urlStr, completionHandler: completion, errorHandler: errorHanlder)
        
    }
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        loadElements()
    }
    
}

//Table Data Source Extension
extension ElementViewController: UITableViewDataSource {
    
    
    //Number of Rows in Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard elements?.count != nil else{return 0}
        return self.elements!.count
    }
    
    
    //Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath)
        let anElement = elements![indexPath.row]
        
        if let cell = cell as? ElementTableViewCell {
            cell.elementNameLabel.text = anElement.name
            cell.elementSymbolAngWeighLabel.text = "\(anElement.symbol) \(anElement.weight)"
            
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         
            var elementID = "001"
            if String(anElement.id).count == 1 {
                elementID = "00\(anElement.id)"
            } else if String(anElement.id).count == 2 {
                elementID = "0\(anElement.id)"
            } else if String(anElement.id).count == 3 {
                elementID = anElement.id.description
            }
            //Image
            cell.elementImage.image = #imageLiteral(resourceName: "GTOA01-3D-handmade-wood-mosaic-dimensional-depth-artistic-trendy-unique-tile-by-globaltrendsbuildingsupply-Recovered")
            let imageUrlStr = "http://www.theodoregray.com/periodictable/Tiles/\(elementID)/s7.JPG"
            
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.elementImage.image = onlineImage
                cell.setNeedsLayout()
                cell.activityIndicator.stopAnimating()
            }
            
            cell.activityIndicator.startAnimating()
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
            
            return cell
        }
        return cell
    }
    
    //Segue
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedElementViewController {
            let selectedElement = elements![(tableView.indexPathForSelectedRow?.row)!]
            destination.element = selectedElement
        }
}


}










