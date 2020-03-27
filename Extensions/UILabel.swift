//
//  UILabel.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 11/5/19.
//  Copyright © 2019 carpino corp. All rights reserved.
//

import UIKit

extension UILabel {

    
    var substituteFontName : String {
        get {
            var fontName: String!
            DispatchQueue.main.async {
                
                fontName = self.font!.fontName
            }
            return fontName
            
        }
        set {
            var fontSize: CGFloat = 0
            DispatchQueue.main.async {
                fontSize = self.font?.pointSize ?? 17
            }
                self.font = UIFont(name: newValue, size: fontSize)
            
        }
    }
    
    
    var substituteFontNameBold : String {
        get {
            var fontName: String!
            DispatchQueue.main.async {
                
                fontName = self.font!.fontName
            }
            return fontName
            
        }
        set {
            var fontSize: CGFloat = 0
            DispatchQueue.main.async {
                fontSize = self.font?.pointSize ?? 19
            }
                self.font = UIFont(name: newValue, size: fontSize)
            
        }
    }
}
