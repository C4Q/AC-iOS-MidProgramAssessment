//
//  ElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
 
    @IBOutlet weak var elementsTableView: UITableView!
    @IBOutlet weak var elementsSearchBar: UISearchBar!
    var elements = [Element](){
        didSet{
            elementsTableView.reloadData()
        }
    }
    var filteredElements: [Element]{
            guard searchTerm != "" else {
                return elements
        }
        return elements.filter{$0.name.lowercased().contains(searchTerm.lowercased())}
        }
    
    var searchTerm: String = ""{
        didSet{
//            self.filteredElements = elements.filter{$0.name.lowercased().contains(searchTerm.lowercased())}
            elementsTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text!
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementSetup = filteredElements[indexPath.row]
        guard let cell: UITableViewCell = elementsTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = elementSetup.name
            return defaultCell
        }
        
        cell.textLabel?.text = elementSetup.name
        cell.detailTextLabel?.text = elementSetup.symbol.description
        cell.imageView?.image = #imageLiteral(resourceName: "defaultImage")
        if let imageNumber = elementSetup.imageNumber{
        ImageAPIClient.manager.getImage(from: "http://www.theodoregray.com/periodictable/Tiles/\(imageNumber)/s7.JPG", completionHandler: {cell.imageView?.image = $0; cell.setNeedsLayout()}, errorHandler: {print($0)})
        }
        return cell
    } 
    func loadElements(){
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        ElementAPIClient.manager.getElements(from: urlStr, completionHandler: {self.elements = $0}, errorHandler: {print($0)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elementsTableView.delegate = self
        self.elementsTableView.dataSource = self
        self.elementsSearchBar.delegate = self
        loadElements()
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedElementViewController{
            let elementSetup = filteredElements[(elementsTableView.indexPathForSelectedRow?.row)!]
            destination.element = elementSetup
        }
    }
    

}
