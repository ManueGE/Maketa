//
//  NSLayoutConstraint+Maketa.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 11/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

public extension NSLayoutConstraint {
    /// A more semantic way to create empty `NSLayoutConstraint`
    public static var empty: NSLayoutConstraint { return NSLayoutConstraint() }
    
    /// Activates the receiver constraint and returns itself
    @discardableResult
    public func activated() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
