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
    
    var superLayout: Layout {
        guard let superview = view.superview else {
            fatalError("\(self) has not a superview, so layout.\(#function) can't be used")
        }
        return superview.layout
    }
}
