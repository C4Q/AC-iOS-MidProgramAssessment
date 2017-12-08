//
//  DetailController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Masai Young on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var element: Element!
    
    @IBOutlet weak var discoveryYearLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    
    @IBAction func postElement(_ sender: Any) {
        let elementToPost = PostElement(name: "Masai", favorite_element: element.symbol)
        let favoritesEndpoint = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        PostElementAPIClient.manager.getElements(from: favoritesEndpoint,
                                                 HTTPVerb: .POST,
                                                 element: elementToPost,
                                                 completionHandler: {print($0)},
                                                 errorHandler: {print($0)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ImageDownloader.manager.getImage(from: element.largeImageEndpoint,
                                         completionHandler: {self.mainImageView.image = UIImage(data: $0)},
                                         errorHandler: {self.mainImageView.image = UIImage(named: "ElementalNinja")})
        self.title = element.name
        setUpLabels(from: element)
    }
    
    func setUpLabels(from element: Element) {
        nameLabel.text = element.name
        symbolLabel.text = element.symbol
        
        IDLabel.text = element.id.description
        weightLabel.text = element.weight.description
        
        meltingLabel.text = (element.meltingC?.description ?? "") + "°C"
        boilingLabel.text = (element.boilingC?.description ?? "") + "°C"
        
        discoveryYearLabel.text = {
            switch element.discoveryYear {
            case let .integer(intValue):
                return intValue.description
            case let .string(strValue):
                return strValue.capitalized
            }
        }()
    }
    
}
