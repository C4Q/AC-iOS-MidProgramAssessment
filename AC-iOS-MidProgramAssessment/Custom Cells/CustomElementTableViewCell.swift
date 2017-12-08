//
//  CustomElementTableViewCell.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class CustomElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementAtomicNumberAndWeightLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
