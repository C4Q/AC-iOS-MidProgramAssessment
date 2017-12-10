//
//  DetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var element: ElementInfo!
    
    @IBOutlet weak var titleElement: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var symbolAndNumber: UILabel!
    @IBOutlet weak var BigImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        boilingPoint.text = element.boiling_c?.description
        meltingPoint.text = element.melting_c?.description
        weight.text = element.weight.description
        symbolAndNumber.text = element.symbol + "\(element.number)"
        titleElement.text = element.name
        loadImage()
    }
    
    func loadImage() {
        guard let url = URL(string: "http://images-of-elements.com/\(element.name.lowercased()).jpg") else {return}
        let myGlobalQueue = DispatchQueue.global(qos: .utility)
        myGlobalQueue.async {
            print("About to make network connection")
            guard let rawImageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImageData) else {return}
                self.BigImage.image = onlineImage
               
            }
            print("Just dispatched to main queue")
        }
        print("Just dispatched to global queue")
    }


}
