//
//  Layout.swift
//  Layout
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public class Layout {
    
    internal struct Defaults {
        static let relation = NSLayoutRelation.equal
        static let priority = UILayoutPriority.required
    }
    
    weak var view: UIView!
    
    // MARK: Inits
    init(view: UIView) {
        self.view = view
        view.preparedForAutolayout()
    }
}
