//
//  CustomTableViewCell.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Richard Crichlow on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolNumberAtomWeightLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
