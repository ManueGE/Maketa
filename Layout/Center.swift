//
//  Center.swift
//  Layout
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public struct Center {
    fileprivate let view: UIView
    fileprivate var offset = UIOffset.zero
    
    fileprivate init(view: UIView) {
        self.view = view
    }
}

public func + (center: Center, offset: UIOffset) -> Center {
    var center = center
    center.offset.horizontal += offset.horizontal
    center.offset.vertical += offset.vertical
    return center
}

public func - (center: Center, offset: UIOffset) -> Center {
    return center + UIOffset(horizontal: -offset.horizontal, vertical: -offset.vertical)
}

public func + (center: Center, inset: CGFloatConvertible) -> Center {
    let value = inset.layoutCGFloat
    let offset = UIOffset(horizontal: value, vertical: value)
    return center + offset
}

public func - (center: Center, offset: CGFloatConvertible) -> Center {
    return  center + -offset.layoutCGFloat
}

public extension Layout {
    public var center: Center {
        get {
            return Center(view: view)
        }
        set {
            view.layout.centerX = newValue.view.layout.centerX + newValue.offset.horizontal
            view.layout.centerY = newValue.view.layout.centerY + newValue.offset.vertical
        }
    }
}
