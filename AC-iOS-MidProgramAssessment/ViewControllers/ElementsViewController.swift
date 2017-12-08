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
    
    var elements = [ElementInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tableView.dataSource = self
        loadElements()
        
       
      
    }

    func loadElements() {
     let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
     let completion: ([ElementInfo]) -> Void = {(onlineElements: [ElementInfo]) in
            self.elements = onlineElements
        }
        let errorHandler: (AppError) -> Void = {(error: AppError) in ()}
        ElementAPIClient.manager.getElements(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
    
}
    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
           destination.element = self.elements[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as! CustomTableViewCell
        let element = self.elements[indexPath.row]
        cell.name.text = element.name
        cell.symbolNumberWeight.text = element.symbol + "\(String(describing: element.number))"  + (element.weight.description)
        cell.elementImage.image = nil
        
        func loadImage() {
            guard let url = URL(string: "http://www.theodoregray.com/periodictable/Tiles/018/s7.JPG") else {return}
            let myGlobalQueue = DispatchQueue.global(qos: .utility)
            myGlobalQueue.async {
                print("About to make network connection")
                guard let rawImageData = try? Data(contentsOf: url) else {return}
                DispatchQueue.main.async {
                    guard let onlineImage = UIImage(data: rawImageData) else {return}
                    cell.elementImage.image = onlineImage
                   
                    
                }
                print("Just dispatched to main queue")
            }
            print("Just dispatched to global queue")
        }

//
       return cell
    }
}
