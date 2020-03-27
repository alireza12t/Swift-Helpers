//
//  TextFieldExtension.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 10/24/19.
//  Copyright © 2019 carpino corp. All rights reserved.
//

import UIKit



extension UITextField {
    
    
    /// Add Buttons to Keyboard Toolbar
    func addCancelSendItems( cancelTitle: String = StringHelper.getClose(), onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: cancelTitle, style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    func clearToolbar(){
        self.inputAccessoryView = nil
    }
    
    
    // Default actions:
    @objc func sendButtonTapped() { self.resignFirstResponder() }
    
    @objc func cancelButtonTapped() {
        self.resignFirstResponder()
    }
    
    
    
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
    
    
    
    
    
}


