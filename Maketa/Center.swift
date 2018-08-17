//
//  Center.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

/// A struct used to match the constraints associated to the center of a `UIView` to the center of another `UIView`.
public struct Center {
    fileprivate let view: UIView
    fileprivate var offset = UIOffset.zero
    fileprivate var withinMargins: Bool
    fileprivate var relation = Maketa.Defaults.relation
    fileprivate var priority = Maketa.Defaults.priority
    fileprivate var constraintsPointer: MultiTypePointer<CenterConstraints>?
    
    fileprivate init(view: UIView, withinMargins: Bool) {
        self.view = view
        self.withinMargins = withinMargins
    }
}

// MARK: - Operators
/// Set the center on the left to the center on the right with a `.lessThanOrEqual` relation.
public func < (left: inout Center, right: Center) {
    var newValue = right
    newValue.relation = .lessThanOrEqual
    left = newValue
}

/// Set the center on the left to the center on the right with a `.greaterThanOrEqual` relation.
public func > (left: inout Center, right: Center) {
    var newValue = right
    newValue.relation = .greaterThanOrEqual
    left = newValue
}

/// Set the priority of the given center to the given priority
public func & (center: Center, priority: UILayoutPriority) -> Center {
    var newValue = center
    newValue.priority = priority
    return newValue
}

/// Adds an offset to the given center.
public func + (center: Center, offset: UIOffset) -> Center {
    var center = center
    center.offset.horizontal += offset.horizontal
    center.offset.vertical += offset.vertical
    return center
}

/// Adds an offset to the given center.
public func + (offset: UIOffset, center: Center) -> Center {
    return center + offset
}

/// Substract an offset from the given center.
public func - (center: Center, offset: UIOffset) -> Center {
    return center + UIOffset(horizontal: -offset.horizontal, vertical: -offset.vertical)
}

/// Adds an offset to the given center.
public func + (center: Center, offset: MaketaCGFloatConvertible) -> Center {
    let value = offset.mktCGFloat
    let offset = UIOffset(horizontal: value, vertical: value)
    return center + offset
}

/// Adds an offset to the given center.
public func + (offset: MaketaCGFloatConvertible, center: Center) -> Center {
    return center + offset
}

/// Substract an offset from the given center.
public func - (center: Center, offset: MaketaCGFloatConvertible) -> Center {
    return  center + -offset.mktCGFloat
}

/// Saves the constraints added when the center is applied into the given pointer
public func => (center: Center, constraints: inout CenterConstraints) -> Center {
    var center = center
    center.constraintsPointer = MultiTypePointer(&constraints)
    return center
}

/// Saves the constraints added when the center is applied into the given pointer
public func => (center: Center, constraints: inout CenterConstraints?) -> Center {
    var center = center
    center.constraintsPointer = MultiTypePointer(withOptional: &constraints)
    return center
}

/// Saves the constraints added when the center is applied into the given pointer
public func => (center: Center, constraints: inout CenterConstraints!) -> Center {
    var center = center
    center.constraintsPointer = MultiTypePointer(withForcedUnwrapped: &constraints)
    return center
}

public extension Maketa {
    /// The center along the x and y axis of the object’s alignment rectangle
    public var center: Center {
        get {
            return Center(view: view, withinMargins: false)
        }
        set {
            
            let useMargins = newValue.withinMargins
            let relation = newValue.relation
            
            var xConstraint = NSLayoutConstraint.empty
            let xAttribute = useMargins ? newValue.view.mkt.centerXWithinMargins : newValue.view.mkt.centerX
            let xValue = ((xAttribute + newValue.offset.horizontal) & newValue.priority) => xConstraint
            
            var yConstraint = NSLayoutConstraint.empty
            let yAttribute = useMargins ? newValue.view.mkt.centerYWithinMargins : newValue.view.mkt.centerY
            let yValue = ((yAttribute + newValue.offset.vertical) & newValue.priority) => yConstraint
            
            if useMargins {
                assign(&view.mkt.centerXWithinMargins, to: xValue, with: relation)
                assign(&view.mkt.centerYWithinMargins, to: yValue, with: relation)
            } else {
                assign(&view.mkt.centerX, to: xValue, with: relation)
                assign(&view.mkt.centerY, to: yValue, with: relation)
            }
            
            newValue.constraintsPointer?.setPointee(CenterConstraints(x: xConstraint, y: yConstraint))
        }
    }
    
    /// The center along the x and y between the object’s left and right margin
    public var centerWithinMargins: Center {
        return Center(view: view, withinMargins: true)
    }
}

/// The object returned when the center constraints are assigned.
public struct CenterConstraints {
    
    /// The constraint added for the x attribute
    public let x: NSLayoutConstraint
    
    /// The constraint added for the y attribute
    public let y: NSLayoutConstraint
    
    /// Creates a new instance
    public init() {
        x = .empty
        y = .empty
    }
    
    fileprivate init(x: NSLayoutConstraint, y: NSLayoutConstraint) {
        self.x = x
        self.y = y
    }
}
