//
//  ElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Maryann Yin on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var elementsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
