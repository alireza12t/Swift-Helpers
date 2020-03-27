//
//  UIViewExtension.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 10/27/19.
//  Copyright © 2019 carpino corp. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    ///Make UIVIew Round like circle
    func makeRound() {
        CLog.i()
            layer.cornerRadius = layer.frame.height / 2
            layer.masksToBounds = true
    }
    
    
    ///Make top edge of UIView Round
    func makeTopRound(width: Int = 5, height: Int = 5){
        CLog.i()
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft , .topRight],
                                    cornerRadii: CGSize(width: width, height: height))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    ///Make left edge of UIView Round
    func makeLeftRound(width: Int = 5, height: Int = 5){
        CLog.i()
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft , .bottomLeft],
                                    cornerRadii: CGSize(width: width, height: height))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    
    ///Make right edge of UIView Round
    func makeRightRound(width: Int = 5, height: Int = 5){
        CLog.i()
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight , .bottomRight],
                                    cornerRadii: CGSize(width: width, height: height))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    ///Make bottom edge of UIView Round
    func makeBottomRound(width: Int = 5, height: Int = 5){
        CLog.i()
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft , .bottomRight],
                                    cornerRadii: CGSize(width: width, height: height))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        CLog.i()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = layer.cornerRadius
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]
        
        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addBottomBorder(borderColor: UIColor, borderHeight: CGFloat) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderHeight, width: self.frame.size.width, height: borderHeight)
        self.layer.addSublayer(border)
    }
    
    @IBDesignable
    class DesignableView: UIView {
    }
    
    @IBDesignable
    class DesignableButton: UIButton {
    }
    
    @IBDesignable
    class DesignableLabel: UILabel {
    }
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
}
