//
//  LayoutModifier.swift
//  Layout
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

public protocol LayoutModifier {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint
    func add(_ constant: CGFloat) -> LayoutModifier
    func multiply(by multiplier: CGFloat) -> LayoutModifier
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier
    func setPriority(_ priority: UILayoutPriority) -> LayoutModifier
}

// MARK: - Operators
prefix operator <=
prefix operator >=
infix operator >>>

public func + (modifier: LayoutModifier, constant: CGFloat) -> LayoutModifier {
    return modifier.add(constant)
}

public func - (modifier: LayoutModifier, constant: CGFloat) -> LayoutModifier {
    return modifier.add(-constant)
}

public func * (modifier: LayoutModifier, multiplier: CGFloat) -> LayoutModifier {
    return modifier.multiply(by: multiplier)
}

public func / (modifier: LayoutModifier, multiplier: CGFloat) -> LayoutModifier {
    return modifier.multiply(by: 1 / multiplier)
}

public prefix func <= (modifier: LayoutModifier) -> LayoutModifier {
    return modifier.setRelation(.lessThanOrEqual)
}

public prefix func >= (modifier: LayoutModifier) -> LayoutModifier {
    return modifier.setRelation(.greaterThanOrEqual)
}

public func & (modifier: LayoutModifier, priority: UILayoutPriority) -> LayoutModifier {
    return modifier.setPriority(priority)
}

public func >>> (modifier: LayoutModifier, constraint: inout NSLayoutConstraint) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, constraint: &constraint)
}

public func >>> (modifier: LayoutModifier, constraint: inout NSLayoutConstraint?) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, optionalConstraint: &constraint)
}

public func >>> (modifier: LayoutModifier, constraint: inout NSLayoutConstraint!) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, forcedOptionalConstraint: &constraint)
}

// MARK: - Constants

public extension LayoutModifier where Self: CGFloatConvertible {
    public func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: layoutAttribute,
                                  relatedBy: Layout.Defaults.relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 0,
                                  constant: cgFloat)
    }
    
    public func add(_ constant: CGFloat) -> LayoutModifier {
        return cgFloat + constant
    }
    
    public func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return cgFloat * multiplier
    }
    
    public func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        return LayoutConstant(constant: self.cgFloat, relation: relation, priority: Layout.Defaults.priority)
    }
    
    public func setPriority(_ priority: UILayoutPriority) -> LayoutModifier {
        return LayoutConstant(constant: self.cgFloat, relation: Layout.Defaults.relation, priority: priority)
    }
}

private struct LayoutConstant: LayoutModifier {
    var constant: CGFloat
    var relation: NSLayoutRelation
    var priority: UILayoutPriority
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                                            attribute: layoutAttribute,
                                            relatedBy: relation,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 0,
                                            constant: constant)
        
        constraint.priority = priority
        return constraint
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        var modifier = self
        modifier.constant += constant
        return modifier
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        var modifier = self
        modifier.constant *= multiplier
        return modifier
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        var modifier = self
        modifier.relation = relation
        return modifier
    }
    
    func setPriority(_ priority: UILayoutPriority) -> LayoutModifier {
        var modifier = self
        modifier.priority = priority
        return modifier
    }
}

struct LayoutAttribute: LayoutModifier {
    let view: UIView
    let attribute: NSLayoutAttribute
    fileprivate(set) var constant: CGFloat
    fileprivate(set) var multiplier: CGFloat
    fileprivate(set) var relation: NSLayoutRelation
    fileprivate(set) var priority: UILayoutPriority
    
    init(view: UIView,
                     attribute: NSLayoutAttribute,
                     relation: NSLayoutRelation = Layout.Defaults.relation,
                     priority: UILayoutPriority = Layout.Defaults.priority,
                     constant: CGFloat = 0,
                     multiplier: CGFloat = 1) {
        
        self.view = view
        self.attribute = attribute
        self.relation = relation
        self.priority = priority
        self.constant = constant
        self.multiplier = multiplier
    }
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                                            attribute: layoutAttribute,
                                            relatedBy: relation,
                                            toItem: self.view,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.priority = priority
        return constraint
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        var modifier = self
        modifier.constant += constant
        return modifier
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        var modifier = self
        modifier.multiplier *= multiplier
        return modifier
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        var modifier = self
        modifier.relation = relation
        return modifier
    }
    
    func setPriority(_ priority: UILayoutPriority) -> LayoutModifier {
        var modifier = self
        modifier.priority = priority
        return modifier
    }
}

struct LayoutConstraintSetter: LayoutModifier {
    private let original: LayoutModifier
    private let constraintPointer: UnsafeMutablePointer<NSLayoutConstraint>?
    private let optionalConstraintPointer: UnsafeMutablePointer<NSLayoutConstraint?>?
    private let forcedOptionalConstraintPointer: UnsafeMutablePointer<NSLayoutConstraint!>?
    
    init(original: LayoutModifier, constraint: inout NSLayoutConstraint) {
        self.original = original
        self.constraintPointer = UnsafeMutablePointer(&constraint)
        self.optionalConstraintPointer = nil
        self.forcedOptionalConstraintPointer = nil
    }
    
    init(original: LayoutModifier, optionalConstraint: inout NSLayoutConstraint?) {
        self.original = original
        self.constraintPointer = nil
        self.optionalConstraintPointer = UnsafeMutablePointer(&optionalConstraint)
        self.forcedOptionalConstraintPointer = nil
    }
    
    init(original: LayoutModifier, forcedOptionalConstraint: inout NSLayoutConstraint!) {
        self.original = original
        self.constraintPointer = nil
        self.optionalConstraintPointer = nil
        self.forcedOptionalConstraintPointer = UnsafeMutablePointer(&forcedOptionalConstraint)
    }
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = original.constraint(view: view, layoutAttribute: layoutAttribute)
        constraintPointer?.pointee = constraint
        optionalConstraintPointer?.pointee = constraint
        forcedOptionalConstraintPointer?.pointee = constraint
        return constraint
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        return original.add(constant)
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return original.multiply(by: multiplier)
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        return original.setRelation(relation)
    }
    
    func setPriority(_ priority: UILayoutPriority) -> LayoutModifier {
        return original.setPriority(priority)
    }
}
