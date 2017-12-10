//
//  NewFavoriteViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class NewFavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteElementTextField: UITextField!
    @IBOutlet weak var personNameTextField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   


    @IBAction func postFavoriteElement(_ sender: UIButton) {
        guard let personName = self.personNameTextField.text else {
            //Display message to put order name
            return
        }
        guard let favoriteElementStr = self.favoriteElementTextField.text else {
            //Display message to put order cost
            return
        }
       
        self.personNameTextField.text = ""
        self.favoriteElementTextField.text = ""
        //Make POST request with orderName and orderCost
        let newFavorite = FavoriteInfo(name: personName, favoriteElement: favoriteElementStr)
       FavoriteAPIClient.manager.post(favorite: newFavorite){ print($0) }
    
}

}
