//
//  ElementTableViewCell.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Maryann Yin on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var elementThumbNailImageView: UIImageView!
    
    @IBOutlet weak var elementNameLabel: UILabel!
    
    @IBOutlet weak var elementSymbolAndAtomicWeightLabel: UILabel!
    
}
