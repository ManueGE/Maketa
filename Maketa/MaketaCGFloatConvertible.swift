//
//  MaketaCGFloatConvertible.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

/// A protocol used to transform an object to a CGFloat
public protocol MaketaCGFloatConvertible {
    /// The equivalent `CGFloat` value
    var mktCGFloat: CGFloat { get }
}

extension CGFloat: MaketaCGFloatConvertible {
    public var mktCGFloat: CGFloat { return self }
}

extension Float: MaketaCGFloatConvertible {
    public var mktCGFloat: CGFloat { return CGFloat(self) }
}

extension Int: MaketaCGFloatConvertible {
    public var mktCGFloat: CGFloat { return CGFloat(self) }
}

extension Double: MaketaCGFloatConvertible {
    public var mktCGFloat: CGFloat { return CGFloat(self) }
}
