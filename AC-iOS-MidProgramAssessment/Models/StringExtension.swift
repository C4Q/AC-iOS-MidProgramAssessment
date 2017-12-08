//
//  StringExtension.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Reiaz Gafar on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

extension String {
    
    var threeDigitIntString: String {
        guard Int(self) != nil else { return self }
        guard self.count < 3 else { return self }
        var updatedString = self
        while updatedString.count < 3 {
            updatedString.insert("0", at: updatedString.startIndex)
        }
        return updatedString
    }
}
