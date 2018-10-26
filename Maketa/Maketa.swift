//
//  Maketa.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

/// An object which is associated to a `UIView` and is used to modify its layout constraints
/// It can't be instantiated directly, to access the `Maketa` object of a `view` do `view.mkt`
public class Maketa {
    
    internal struct Defaults {
        static let relation = NSLayoutConstraint.Relation.equal
        static let priority = UILayoutPriority.required
    }
    
    weak var view: UIView!
    
    // MARK: Inits
    internal init(view: UIView) {
        self.view = view
    }
    
    /// Returns the `Maketa` object associated to the superview. If the view is not added to a superview, it throws a fatal error.
	@available(*, deprecated, message: "User `Superview` struct instead` => e.g., replace `view.mkt.super.left` with `Superview.left`")
    public var `super`: Maketa {
        guard let superview = view.superview else { fatalError("\(self) has not a superview, so mkt.\(#function) can't be used") }
        return superview.mkt
    }
}
