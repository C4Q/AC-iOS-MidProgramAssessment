//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Lisa J on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    var element: Element!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var symbolLabel:UILabel!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var weightLabel:UILabel!
    @IBOutlet weak var meltingLabel:UILabel!
    @IBOutlet weak var boilingLabel:UILabel!
   // @IBOutlet weak var discoveryLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImg()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        idLabel.text = "\(element.id)"
        symbolLabel.text = element.symbol
        nameLabel.text = element.name
        weightLabel.text = "\(element.weight)"
        meltingLabel.text = "Melting Point: \(element.melting_c != nil ? "\(element.melting_c!)": "N/A")"
        boilingLabel.text = "Boiling Point: \(element.boiling_c != nil ? "\(element.boiling_c!)": "N/A")"
        
    }
    
    func loadImg() {
        let elementName = element.name.lowercased()
        //let elementId = element.id
        let imageUrl = "http://images-of-elements.com/\(elementName).jpg"
        guard let url = URL(string: imageUrl) else {return}
        //seems to be slightly faster than using the image api client
        let myGlobalQueue = DispatchQueue.global(qos: .utility)
        myGlobalQueue.async {
            guard let rawImageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImageData) else {return}
                self.imgView?.image = onlineImage
                //print(elementName)
                //print(imageUrl)
                //        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                //  }
                //        if elementId < 90 {
                //
                //        }
                //        ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: completion, errorHandler: {print($0)})
            }
        }
    }
            
}
