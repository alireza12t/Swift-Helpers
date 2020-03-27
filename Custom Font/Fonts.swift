//
//  Fonts.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 11/5/19.
//  Copyright © 2019 carpino corp. All rights reserved.
//

import UIKit


extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: fontConstants.regularFont, size: size)!
    }
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: fontConstants.boldFont, size: size)!
    }
}



struct fontConstants{
    
    static let regularFont = "IRANSans-Light"
    static let boldFont = "IRANSans-Bold"
}
