//
//  Helpers.swift
//  Layout
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    public static var empty: NSLayoutConstraint { return NSLayoutConstraint() }
}

public protocol CGFloatConvertible {
    var layoutCGFloat: CGFloat { get }
}

extension CGFloat: CGFloatConvertible {
    public var layoutCGFloat: CGFloat { return self }
}

extension Float: CGFloatConvertible {
    public var layoutCGFloat: CGFloat { return CGFloat(self) }
}

extension Int: CGFloatConvertible {
    public var layoutCGFloat: CGFloat { return CGFloat(self) }
}

extension Double: CGFloatConvertible {
    public var layoutCGFloat: CGFloat { return CGFloat(self) }
}
