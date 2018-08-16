//
//  Modifiers.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

/// Applies the modifiers on the right into the left item with a `.lessThanOrEqual` relation.
public func < (left: inout AttributeModifier, right: AttributeModifier) {
    left = right.setRelation(.lessThanOrEqual)
}

/// Applies the modifiers on the right into the left item with a `.greaterThanOrEqual` relation.
public func > (left: inout AttributeModifier, right: AttributeModifier) {
    left = right.setRelation(.greaterThanOrEqual)
}

/// Set the priority of the given modifier to the given priority
public func & (modifier: AttributeModifier, priority: UILayoutPriority) -> AttributeModifier {
    return modifier.setPriority(priority)
}

/// Adds a constant to the given modifier
public func + (modifier: AttributeModifier, constant: MaketaCGFloatConvertible) -> AttributeModifier {
    return modifier.add(constant.mktCGFloat)
}

/// Adds a constant to the given modifier
public func + (constant: MaketaCGFloatConvertible, modifier: AttributeModifier) -> AttributeModifier {
    return modifier + constant
}

/// Substract a constant from the given modifier
public func - (modifier: AttributeModifier, constant: MaketaCGFloatConvertible) -> AttributeModifier {
    return modifier.add(-constant.mktCGFloat)
}

/// Multiply the given modifier by a multiplier
public func * (modifier: AttributeModifier, multiplier: MaketaCGFloatConvertible) -> AttributeModifier {
    return modifier.multiply(by: multiplier.mktCGFloat)
}

/// Multiply the given modifier by a multiplier
public func * (multiplier: MaketaCGFloatConvertible, modifier: AttributeModifier) -> AttributeModifier {
    return modifier * multiplier
}

/// Divide the given modifier by a dividet
public func / (modifier: AttributeModifier, divider: MaketaCGFloatConvertible) -> AttributeModifier {
    return modifier * (1 / divider.mktCGFloat)
}

/// Saves the constraint added when the modifier is applied into the given pointer
public func => (modifier: AttributeModifier, constraint: inout NSLayoutConstraint) -> AttributeModifier {
    return LayoutConstraintSetter(original: modifier, constraint: &constraint)
}

/// Saves the constraint added when the modifier is applied into the given pointer
public func => (modifier: AttributeModifier, constraint: inout NSLayoutConstraint?) -> AttributeModifier {
    return LayoutConstraintSetter(original: modifier, optionalConstraint: &constraint)
}

/// Saves the constraint added when the modifier is applied into the given pointer
public func => (modifier: AttributeModifier, constraint: inout NSLayoutConstraint!) -> AttributeModifier {
    return LayoutConstraintSetter(original: modifier, forcedOptionalConstraint: &constraint)
}

// MARK: - Constants
extension CGFloat: AttributeModifier {}
extension Float: AttributeModifier {}
extension Int: AttributeModifier {}
extension Double: AttributeModifier {}

public extension AttributeModifier where Self: MaketaCGFloatConvertible {
    public func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let attribute = LayoutAttribute(view: nil, attribute: .notAnAttribute, constant: mktCGFloat)
        return attribute.constraint(view: view, layoutAttribute: layoutAttribute)
    }
    
    public func add(_ constant: CGFloat) -> AttributeModifier {
        return mktCGFloat + constant
    }
    
    public func multiply(by multiplier: CGFloat) -> AttributeModifier {
        return mktCGFloat * multiplier
    }
    
    public func setRelation(_ relation: NSLayoutRelation) -> AttributeModifier {
        return LayoutAttribute(view: nil, attribute: .notAnAttribute, relation: relation, constant: mktCGFloat)
    }
    
    public func setPriority(_ priority: UILayoutPriority) -> AttributeModifier {
        return LayoutAttribute(view: nil, attribute: .notAnAttribute, priority: priority, constant: mktCGFloat)
    }
}

struct LayoutAttribute: AttributeModifier {
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
    
    func add(_ constant: CGFloat) -> AttributeModifier {
        var modifier = self
        modifier.constant += constant
        return modifier
    }
    
    func multiply(by multiplier: CGFloat) -> AttributeModifier {
        var modifier = self
        modifier.multiplier *= multiplier
        return modifier
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> AttributeModifier {
        var modifier = self
        modifier.relation = relation
        return modifier
    }
    
    func setPriority(_ priority: UILayoutPriority) -> AttributeModifier {
        var modifier = self
        modifier.priority = priority
        return modifier
    }
}

struct LayoutConstraintSetter: AttributeModifier {
    private(set) var original: AttributeModifier
    private let constraintPointer: MultiTypePointer<NSLayoutConstraint>
    
    init(original: AttributeModifier, constraint: inout NSLayoutConstraint) {
        self.original = original
        self.constraintPointer = MultiTypePointer(&constraint)
    }
    
    init(original: AttributeModifier, optionalConstraint: inout NSLayoutConstraint?) {
        self.original = original
        self.constraintPointer = MultiTypePointer(withOptional: &optionalConstraint)
    }
    
    init(original: AttributeModifier, forcedOptionalConstraint: inout NSLayoutConstraint!) {
        self.original = original
        self.constraintPointer = MultiTypePointer(withForcedUnwrapped: &forcedOptionalConstraint)
    }
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = original.constraint(view: view, layoutAttribute: layoutAttribute)
        constraintPointer.setPointee(constraint)
        return constraint
    }
    
    func add(_ constant: CGFloat) -> AttributeModifier { fatalError("Can't modify a `AttributeModifier` after it is assigned") }
    
    func multiply(by multiplier: CGFloat) -> AttributeModifier { fatalError("Can't modify a `AttributeModifier` after it is assigned") }
    
    func setPriority(_ priority: UILayoutPriority) -> AttributeModifier { fatalError("Can't modify a `AttributeModifier` after it is assigned") }
    
    func setRelation(_ relation: NSLayoutRelation) -> AttributeModifier {
        var modifier = self
        modifier.original = original.setRelation(relation)
        return modifier
    }
}
