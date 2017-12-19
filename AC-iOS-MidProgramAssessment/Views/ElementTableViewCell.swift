//
//  ElementTableViewCell.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {


        
        @IBOutlet weak var elementImage: UIImageView!
        
        @IBOutlet weak var elementNameLabel: UILabel!
        
        @IBOutlet weak var elementSymbolLabel: UILabel!
        
        @IBOutlet weak var elementWeightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
