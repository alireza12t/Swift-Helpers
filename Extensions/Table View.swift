//
//  Table View.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 2/24/20.
//  Copyright © 2020 carpino corp. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension UITableView {
    
    ///TableView reloadData with completion handler
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}


