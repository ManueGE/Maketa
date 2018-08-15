//
//  MaketaCGFloatConvertible.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public protocol LayoutCGFloatConvertible {
    var layoutCGFloat: CGFloat { get }
}

extension CGFloat: LayoutCGFloatConvertible {
    public var layoutCGFloat: CGFloat { return self }
}

extension Float: LayoutCGFloatConvertible {
    public var layoutCGFloat: CGFloat { return CGFloat(self) }
}

extension Int: LayoutCGFloatConvertible {
    public var layoutCGFloat: CGFloat { return CGFloat(self) }
}

extension Double: LayoutCGFloatConvertible {
    public var layoutCGFloat: CGFloat { return CGFloat(self) }
}
