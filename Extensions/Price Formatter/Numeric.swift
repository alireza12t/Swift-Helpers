//
//  Numeric.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/30 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import Foundation
extension Numeric {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
