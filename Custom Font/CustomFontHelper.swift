//
//  FontHelper.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/07 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import UIKit


//This class gice the specified Font with the custom size
class FontHelper {
    class func getIRANSansMobile(size: CGFloat) -> UIFont{
        return UIFont(name: "IRANSansMobile", size: size)!
    }
    class func getIRANSansMobileBold(size: CGFloat) -> UIFont{
        return UIFont(name: "IRANSansMobile-Bold", size: UIFont.systemFontSize)!
    }
    class func getIRANSansMobileLight(size: CGFloat) -> UIFont{
        return UIFont(name: "IRANSansMobile-Light", size: UIFont.systemFontSize)!
    }
    class func getIRANSansMobileMedium(size: CGFloat) -> UIFont{
        return UIFont(name: "IRANSansMobile-Medium", size: UIFont.systemFontSize)!
    }
    class func getIRANSansMobileUltraLight(size: CGFloat) -> UIFont{
        return UIFont(name: "IRANSansMobile-UltraLight", size: UIFont.systemFontSize)!
    }
}
