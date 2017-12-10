//
//  PeriodicElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit


//full size images
// http://images-of-elements.com/lowercasedElementName.jpg


class PeriodicElementsViewController: UIViewController {
    
    @IBOutlet weak var elementsTableView: UITableView!
    @IBOutlet weak var activitySpinner1: UIActivityIndicatorView!
    
    //what is powering app
    var periodicElements = [PeriodicElement]() {
        didSet{
            elementsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsTableView.dataSource = self
        elementsTableView.delegate = self
        activitySpinner1.isHidden = true
        getPeriodicElementData()
    }
    
    func getPeriodicElementData(){
        //ElementAPIClient
        // link to access all the data
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        //set completion
        let completion: ([PeriodicElement]) -> Void = {(onlineElement: [PeriodicElement]) in
            self.periodicElements = onlineElement
            //PeriodicElements generated and put into the array
        }
        //set errorHandler
        let errorHandler: (Error) -> Void = {(error: Error) in
            //alert pop up box: bad url
            let alertController = UIAlertController(title: "Error", message: "An error occurred: \(AppError.badURL)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            alertController.view.layoutIfNeeded() //avoid Snapshotting error
            self.present(alertController, animated: true, completion: nil)
        }
        //call ElementsAPIClient
        ElementAPIClient.manager.getElements(from: urlStr,
                                             completionHandler: completion,
                                             errorHandler: errorHandler) //errorHandler
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailElementsViewController{
            let selectedRow = self.elementsTableView.indexPathForSelectedRow!.row
            let selectedElement = self.periodicElements[selectedRow]
            //sending url of element image over
            destination.detailElement = selectedElement
            //let elementName = PeriodicElement.CodingKeys.name
            //"http://images-of-elements.com/\(elementName).jpg"
            print(selectedElement.name)
        }
    }
}


/// MARK: - TableView for periodic elements
extension PeriodicElementsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodicElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = periodicElements[indexPath.row]
        
        guard let elementCell = elementsTableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementTableViewCell else {
            //make default cell
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = element.name
            defaultCell.detailTextLabel?.text = element.symbol
            defaultCell.imageView?.image = #imageLiteral(resourceName: "noImg")
            return defaultCell
        }
        
        //set properties
        
        elementCell.elementNameLabel.text = "\(element.name)" //(Sodium)
        elementCell.elementSymbolLabel.text = "\(element.symbol,"(\(String(describing: element.number))")" //Na(11)
        elementCell.elementWeightLabel.text = "\(String(describing: element.weight))" //12.111
        
        //set border and border color
        elementCell.layer.borderWidth = 5
        elementCell.layer.borderColor = UIColor.black.cgColor
        
       // elementCell.elementImage.image = #imageLiteral(resourceName: "noImg") //defaultImage
        
        //settingImage
        //make sure you can convert the url into an image
        let imageUrlStr = element.thumbNailImage
                activitySpinner1.isHidden = false
                activitySpinner1.startAnimating()
                let completion : (UIImage) -> Void = {(onlineImage: UIImage) in
                    elementCell.imageView?.image = onlineImage
                    elementCell.setNeedsLayout()//image loads as soon as it's ready
                    self.activitySpinner1.isHidden = true
                    self.activitySpinner1.stopAnimating()
                }
        
                ImageAPIClient.manager.getImage(from: imageUrlStr,
                                                completionHandler: completion,
                                                errorHandler: {print($0)})
        return elementCell
    }
}


