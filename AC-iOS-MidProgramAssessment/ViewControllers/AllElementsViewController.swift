//
//  AllElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class AllElementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource/*, UISearchBarDelegate*/ {

    
    //MARK: - Variables
    var elements = [ElementInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
//    var searchTerm = "" {
//        didSet {
//            loadData()
//            tableView.reloadData()
//        }
//    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        let urlString = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements/"
        let completion: ([ElementInfo]) -> Void = {(onlineElements: [ElementInfo]) in
            self.elements = onlineElements
            }
        let printErrors = {(error: Error) in
            print(error)
        }
        ElementAPIClient.manager.getElement(from: urlString,
                                        completionHandler: completion,
                                        errorHandler: printErrors)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? CustomElementCellTableViewCell else { return UITableViewCell()}
        let element = elements[indexPath.row]
        cell.elementNameLabel?.text = element.name
        cell.symbolNumberWeightLabel?.text = "\(element.symbol)(\(element.number)) \(element.weight)"
        cell.elementImage?.image = #imageLiteral(resourceName: "NoImageFound")
        var threeDigitNumber = ""
        switch element.number.description.count{
        case 1:
            threeDigitNumber = "00" + (element.number.description)
        case 2:
            threeDigitNumber = "0" + (element.number.description)
            default:
                threeDigitNumber = ""
        }
        let imageUrlStr = "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitNumber)/s7.JPG"
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.elementImage.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedElementViewController{
            let selectedElement = elements[(tableView.indexPathForSelectedRow?.row)!]
            destination.selectedElement = selectedElement
            }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchTerm = searchBar.text ?? "elements"
//        searchBar.resignFirstResponder()
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchTerm = searchText
//    }

}


