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
    fileprivate var relation = Maketa.Defaults.relation
    fileprivate var priority = Maketa.Defaults.priority
    fileprivate var constraintsPointer: MultiTypePointer<CenterConstraints>?
    
    fileprivate init(view: UIView) {
        self.view = view
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
    /// returns the center of the receiver
    public var center: Center {
        get {
            return Center(view: view)
        }
        set {
            var xConstraint = NSLayoutConstraint.empty
            let xValue = ((newValue.view.mkt.centerX + newValue.offset.horizontal) & newValue.priority) => xConstraint
            
            var yConstraint = NSLayoutConstraint.empty
            let yValue = ((newValue.view.mkt.centerY + newValue.offset.vertical) & newValue.priority) => yConstraint
            
            switch newValue.relation {
            case .equal:
                view.mkt.centerX = xValue
                view.mkt.centerY = yValue
                
            case .lessThanOrEqual:
                view.mkt.centerX < xValue
                view.mkt.centerY < yValue
                
            case .greaterThanOrEqual:
                view.mkt.centerX > xValue
                view.mkt.centerY > yValue
            }
            
            newValue.constraintsPointer?.setPointee(CenterConstraints(x: xConstraint, y: yConstraint))
        }
    }
}

/// The object returned when the center constraints are assigned.
public struct CenterConstraints {
    
    /// The constraint added for the x attribute
    public let x: NSLayoutConstraint
    
    /// The constraint added for the y attribute
    public let y: NSLayoutConstraint
    
    /// An array with all the constraints. The order will be x, y
    public var array: [NSLayoutConstraint] { return [x, y] }
    
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
