//
//  NSLayoutConstraint+Layout.swift
//  Layout
//
//  Created by Manuel García-Estañ on 11/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

public extension NSLayoutConstraint {
    public static var empty: NSLayoutConstraint { return NSLayoutConstraint() }
    
    @discardableResult
    public func activated() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
