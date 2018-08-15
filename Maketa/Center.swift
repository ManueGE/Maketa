//
//  Center.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public struct Center {
    fileprivate let view: UIView
    fileprivate var offset = UIOffset.zero
    fileprivate var constraintsPointer: MultiTypePointer<[NSLayoutConstraint]>?
    
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

public func + (offset: UIOffset, center: Center) -> Center {
    return center + offset
}

public func - (center: Center, offset: UIOffset) -> Center {
    return center + UIOffset(horizontal: -offset.horizontal, vertical: -offset.vertical)
}

public func + (center: Center, offset: LayoutCGFloatConvertible) -> Center {
    let value = offset.layoutCGFloat
    let offset = UIOffset(horizontal: value, vertical: value)
    return center + offset
}

public func + (offset: LayoutCGFloatConvertible, center: Center) -> Center {
    return center + offset
}

public func - (center: Center, offset: LayoutCGFloatConvertible) -> Center {
    return  center + -offset.layoutCGFloat
}

public func => (center: Center, constraints: inout [NSLayoutConstraint]) -> Center {
    var center = center
    center.constraintsPointer = MultiTypePointer(&constraints)
    return center
}

public func => (center: Center, constraints: inout [NSLayoutConstraint]?) -> Center {
    var center = center
    center.constraintsPointer = MultiTypePointer(withOptional: &constraints)
    return center
}

public func => (center: Center, constraints: inout [NSLayoutConstraint]!) -> Center {
    var center = center
    center.constraintsPointer = MultiTypePointer(withForcedUnwrapped: &constraints)
    return center
}

public extension Maketa {
    public var center: Center {
        get {
            return Center(view: view)
        }
        set {
            var xConstraint = NSLayoutConstraint.empty
            view.mkt.centerX = (newValue.view.mkt.centerX + newValue.offset.horizontal) => xConstraint
            
            var yConstraint = NSLayoutConstraint.empty
            view.mkt.centerY = (newValue.view.mkt.centerY + newValue.offset.vertical) => yConstraint
            
            newValue.constraintsPointer?.setPointee([xConstraint, yConstraint])
        }
    }
}
