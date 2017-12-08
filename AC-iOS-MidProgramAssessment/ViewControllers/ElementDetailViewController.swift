//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    var selectedElement: Element?
    
    @IBOutlet weak var detailMeltingLabel: UILabel!
    @IBOutlet weak var detailBoilingLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNumberLabel: UILabel!
    @IBOutlet weak var detailSymbolLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailWeightLabel: UILabel!
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let newFav = FavoriteElement(name: "Nathan", favorite_element: (selectedElement?.symbol)!)
        FavoriteAPIClient.manager.post(favorite: newFav, errorHandler: {print($0)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        detailNameLabel.text = selectedElement?.name
        detailNumberLabel.text = selectedElement?.id?.description
        detailSymbolLabel.text = selectedElement?.symbol
        detailWeightLabel.text = selectedElement?.weight.description
        detailBoilingLabel.text = "Boiling Point: \(selectedElement?.boiling_c ?? 0)"
        detailMeltingLabel.text = "Melting Point: \(selectedElement?.melting_c ?? 0)"
        let imageURL = "http://images-of-elements.com/\(selectedElement?.name.lowercased() ?? "N/A").jpg"
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: {self.detailImageView.image = $0}, errorHandler: {print($0)})
        navigationItem.title = selectedElement?.name
    }
    

}
