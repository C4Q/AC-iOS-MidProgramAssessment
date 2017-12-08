//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Luis Calle on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var element: Element?
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveryNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let element = element else { return }
        titleNameLabel.text = element.name
        meltingPointLabel.text = element.melting_c?.description ?? "Melting point N/A"
        boilingPointLabel.text = element.boiling_c?.description ?? "Boiling point N/A"
        discoveryNameLabel.text = "Coming soon..."
        loadLargeElemImage(element: element)
    }
    
    func loadLargeElemImage(element: Element) {
        let largeImageURLStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        let imageCompletion: (UIImage) -> Void = { (onlineLargeImage: UIImage) in
            self.elementImage.image = onlineLargeImage
            self.elementImage.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: largeImageURLStr, completionHandler: imageCompletion, errorHandler: {print($0)} )
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
    }
    

}
