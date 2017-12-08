//
//  AllElementsViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class AllElementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var elements = [ElementInfo]()
    
    var searchTerm = "" {
        didSet {
            loadData()
            
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
        
    }
    
    func loadData() {
        let urlString = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let completion: ([ElementInfo]) -> Void = {(onlineElements: [ElementInfo]) in
            dispatchMain {
                self.elements = onlineElements
            }
        }
        
        ElementAPIClient.manager.getElement(from: urlString,
                                        completionHandler: completion,
                                        errorHandler: { [weak self] error in
                                            self?.showAlert(error: error)})
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        let element = elements[indexPath.row]
        cell.textLabel?.text = element.element.name ?? "No Name Available"
        cell.detailTextLabel?.text = "\(element.element.symbol)(\(element.element.number) \(element.element.weight)"
        cell.imageView?.image = nil
        guard let imageUrlStr = eleme.show.image?.medium else {
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }

    func showAlert(error: AppError) {
        let alert = UIAlertController(title: "Network Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        dispatchMain { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

func dispatchMain(_ task: @escaping () -> Void) {
    if Thread.isMainThread {
        task()
    } else {
        DispatchQueue.main.async {
            task()
        }
    }
}
