//
//  String+Extension.swift
//  exmo-ios-client
//
//  Created by Bogdan Sasko on 1/14/19.
//  Copyright © 2019 Bogdan Sasko. All rights reserved.
//

import Foundation

// MARK: - Localization

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
