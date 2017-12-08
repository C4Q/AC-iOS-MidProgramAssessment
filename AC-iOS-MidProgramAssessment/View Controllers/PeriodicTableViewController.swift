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
    
    var elements: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodicTableView.delegate = self
        periodicTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //to do
    }

}

//Table View Methods
extension PeriodicTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // to do
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        
        if let elementCell = cell as? ElementTableViewCell {
            
            //to do
            
            return elementCell
        }
        
        return cell
    }
}
