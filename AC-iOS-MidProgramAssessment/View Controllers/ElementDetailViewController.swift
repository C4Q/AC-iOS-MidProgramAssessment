//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    
    @IBOutlet weak var elementNavigationTitle: UINavigationItem!
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementTileView: UIView!
    @IBOutlet weak var elementNumberLabel: UILabel!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementWeightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveryYearLabel: UILabel!
    
    @IBOutlet var elementTileLabels: [UILabel]!
    
    var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        let color: (red: CGFloat, green: CGFloat, blue: CGFloat) = BackgroundColor.forElement(group: element.group, symbol: element.symbol) ?? (1,1,1)
        let inverseColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = BackgroundColor.inverseForElement(group: element.group, symbol: element.symbol) ?? (0,0,0)
        
        elementTileView.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
        
        elementTileLabels.forEach{$0.textColor = UIColor(red: inverseColor.red, green: inverseColor.green, blue: inverseColor.blue, alpha: 1)}
        
        elementNavigationTitle.title = element.name
        elementNumberLabel.text = element.number.description
        elementSymbolLabel.text = element.symbol
        elementNameLabel.text = element.name
        elementWeightLabel.text = element.weight.description
        meltingPointLabel.text = element.meltingPoint?.description ?? "No information available"
        boilingPointLabel.text = element.boilingPoint?.description ?? "No information available"
        discoveryYearLabel.text = element.discoveryYearAsInt?.description ?? element.discoveryYearAsString?.capitalized
        
        setupImages()
    }
    
    func setupImages() {
        let urlString = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        elementImageView.image = #imageLiteral(resourceName: "placeholder")
        
        ImageAPIClient.manager.getImages(
            from: urlString,
            completionHandler: { (onlineImage) in
                self.elementImageView.image = onlineImage
        },
            errorHandler: { (appError) in
                let errorMessage: String
                
                switch appError {
                case .badImageURL(let string):
                    errorMessage = "Bad Image URL:\n\(string)"
                case .badStatusCode(let num):
                    errorMessage = "Bad Status Code: \(num)"
                case .other(let rawError):
                    errorMessage = "No Image Available On Database.\n\(rawError)"
                default:
                    errorMessage = "No Image Available On Database.\n\(appError.localizedDescription)"
                }
                
                let alertController = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                
                self.present(alertController, animated: true, completion: nil)
        })
    }
}
