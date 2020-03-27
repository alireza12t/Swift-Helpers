//
//  UIButton.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/06 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import UIKit

extension UIButton {

    func centerVertically(padding: CGFloat = 15.0) {
        guard
            let imageViewSize = imageView?.frame.size,
            let titleLabelSize = titleLabel?.frame.size else {
                return
        }

        let totalHeight = imageViewSize.height + titleLabelSize.height + padding

        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )

        contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
        titleLabel?.textAlignment = .center

    }
    func addRightBorder(borderColor: UIColor, borderWidth: CGFloat, verticalGap: CGFloat) {
        if frame.size.height > verticalGap * 2 {
            let border = CALayer()
            border.backgroundColor = borderColor.cgColor
            border.frame = CGRect(x: frame.size.width - borderWidth, y: verticalGap, width: borderWidth, height: frame.size.height - 2 * verticalGap)
            layer.addSublayer(border)
        }
    }

    func addLeftBorder(borderColor: UIColor, borderWidth: CGFloat, verticalGap: CGFloat) {
        if frame.size.height > verticalGap * 2 {
            let border = CALayer()
            border.backgroundColor = borderColor.cgColor
            border.frame = CGRect(x: 0, y: verticalGap, width: borderWidth, height: frame.size.height - 2 * verticalGap)
            layer.addSublayer(border)
        }
    }
    func addToTitleTopEdge(){
        titleEdgeInsets.top = 5
    }
}
