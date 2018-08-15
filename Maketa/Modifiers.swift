//
//  Modifiers.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

// MARK: - Operators
infix operator => : BitwiseShiftPrecedence

public func < (left: inout LayoutModifier, right: LayoutModifier) {
    left = right.setRelation(.lessThanOrEqual)
}

public func > (left: inout LayoutModifier, right: LayoutModifier) {
    left = right.setRelation(.greaterThanOrEqual)
}

public func & (modifier: LayoutModifier, priority: UILayoutPriority) -> LayoutModifier {
    return modifier.setPriority(priority)
}

public func + (modifier: LayoutModifier, constant: CGFloat) -> LayoutModifier {
    return modifier.add(constant)
}

public func + (constant: CGFloat, modifier: LayoutModifier) -> LayoutModifier {
    return modifier + constant
}

public func - (modifier: LayoutModifier, constant: CGFloat) -> LayoutModifier {
    return modifier.add(-constant)
}

public func * (modifier: LayoutModifier, multiplier: CGFloat) -> LayoutModifier {
    return modifier.multiply(by: multiplier)
}

public func * (multiplier: CGFloat, modifier: LayoutModifier) -> LayoutModifier {
    return modifier * multiplier
}

public func / (modifier: LayoutModifier, multiplier: CGFloat) -> LayoutModifier {
    return modifier.multiply(by: 1 / multiplier)
}

public func => (modifier: LayoutModifier, constraint: inout NSLayoutConstraint) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, constraint: &constraint)
}

public func => (modifier: LayoutModifier, constraint: inout NSLayoutConstraint?) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, optionalConstraint: &constraint)
}

public func => (modifier: LayoutModifier, constraint: inout NSLayoutConstraint!) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, forcedOptionalConstraint: &constraint)
}

// MARK: - Constants
extension CGFloat: LayoutModifier {}
extension Float: LayoutModifier {}
extension Int: LayoutModifier {}
extension Double: LayoutModifier {}

public extension LayoutModifier where Self: LayoutCGFloatConvertible {
    public func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let attribute = LayoutAttribute(view: nil, attribute: .notAnAttribute, constant: layoutCGFloat)
        return attribute.constraint(view: view, layoutAttribute: layoutAttribute)
    }
    
    public func add(_ constant: CGFloat) -> LayoutModifier {
        return layoutCGFloat + constant
    }
    
    public func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return layoutCGFloat * multiplier
    }
    
    public func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        return LayoutAttribute(view: nil, attribute: .notAnAttribute, relation: relation, constant: layoutCGFloat)
    }
    
    public func setPriority(_ priority: UILayoutPriority) -> LayoutModifier {
        return LayoutAttribute(view: nil, attribute: .notAnAttribute, priority: priority, constant: layoutCGFloat)
    }
}

struct LayoutAttribute: LayoutModifier {
    let view: UIView?
    let attribute: NSLayoutAttribute
    fileprivate(set) var constant: CGFloat
    fileprivate(set) var multiplier: CGFloat
    fileprivate(set) var relation: NSLayoutRelation
    fileprivate(set) var priority: UILayoutPriority
    
    init(view: UIView?,
                     attribute: NSLayoutAttribute,
                     relation: NSLayoutRelation = Maketa.Defaults.relation,
                     priority: UILayoutPriority = Maketa.Defaults.priority,
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
    private(set) var original: LayoutModifier
    private let constraintPointer: MultiTypePointer<NSLayoutConstraint>
    
    init(original: LayoutModifier, constraint: inout NSLayoutConstraint) {
        self.original = original
        self.constraintPointer = MultiTypePointer(&constraint)
    }
    
    init(original: LayoutModifier, optionalConstraint: inout NSLayoutConstraint?) {
        self.original = original
        self.constraintPointer = MultiTypePointer(withOptional: &optionalConstraint)
    }
    
    init(original: LayoutModifier, forcedOptionalConstraint: inout NSLayoutConstraint!) {
        self.original = original
        self.constraintPointer = MultiTypePointer(withForcedUnwrapped: &forcedOptionalConstraint)
    }
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = original.constraint(view: view, layoutAttribute: layoutAttribute)
        constraintPointer.setPointee(constraint)
        return constraint
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier { fatalError("Can't modify a `LayoutModifier` after it is assigned") }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier { fatalError("Can't modify a `LayoutModifier` after it is assigned") }
    
    func setPriority(_ priority: UILayoutPriority) -> LayoutModifier { fatalError("Can't modify a `LayoutModifier` after it is assigned") }
    
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        var modifier = self
        modifier.original = original.setRelation(relation)
        return modifier
    }
}
