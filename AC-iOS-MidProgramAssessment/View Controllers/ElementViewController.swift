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
    var elements: [Element]?{
        didSet{
            tableView.reloadData()
        }
    }
    

    
    //Load Elements
    func loadElements() {
        
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        
        let completion: (Element) -> Void = {(onlineElements: [Element]) in
            self.elements = onlineElements
        }
        
        //          let setStockToOnlineStock: (Stock) -> Void = {(onlineStock: Stock) in
//        self.stock = onlineStock
//    }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath)
        let anElement = elements![indexPath.row]
        
        if let cell = cell as? ElementTableViewCell {
            cell.elementNameLabel.text = anElement.name
            cell.elementSymbolAngWeighLabel.text = "\(anElement.symbol) \(anElement.weight)"
            
            //
            
//            cell.showImage.image = nil
//            guard let imageUrlStr = showToSet.show.image?.medium else{
//                cell.showImage.image = #imageLiteral(resourceName: "photo_not_available_large")
//                cell.activityIndicator.stopAnimating()
//                return cell
//            }
//
//
//
//            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
//                cell.showImage.image = onlineImage
//                cell.setNeedsLayout()
//                //Activity Indicator Stop Animation
//                cell.activityIndicator.stopAnimating()
//
//            }
//
//            //Activity Indicator Start Animation
//            cell.activityIndicator.startAnimating()
//            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
//
   
            
            
            
            
            
            
            
            
            
            
            
            //
            return cell
        }
        return cell
    }
}


















