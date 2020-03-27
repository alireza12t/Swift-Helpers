//
//  Formatter.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/30 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import Foundation
extension Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}
