//
//  UIImage.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 11/4/19.
//  Copyright © 2019 carpino corp. All rights reserved.
//

import UIKit

extension UIImage{
    
    
    ///Add Border to UIImage
    func imageByAddingBorder(width: CGFloat, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: imageRect)
        
        let context = UIGraphicsGetCurrentContext()
        let borderRect = imageRect.insetBy(dx: width / 2, dy: width / 2)
        
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(width)
        context?.stroke(borderRect)
        
        let borderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return borderedImage
    }
    
    
}
