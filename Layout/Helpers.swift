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
    var cgFloat: CGFloat { get }
}

extension CGFloat: CGFloatConvertible, LayoutModifier {
    public var cgFloat: CGFloat { return self }
}

extension Float: CGFloatConvertible, LayoutModifier {
    public var cgFloat: CGFloat { return CGFloat(self) }
}

extension Int: CGFloatConvertible, LayoutModifier {
    public var cgFloat: CGFloat { return CGFloat(self) }
}

extension Double: CGFloatConvertible, LayoutModifier {
    public var cgFloat: CGFloat { return CGFloat(self) }
}
