//
//  Layout.swift
//  Layout
//
//  Created by Manuel García-Estañ on 12/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

class Layout {
    weak var view: UIView!
    
    init(view: UIView) {
        self.view = view
        view.prepareForAutolayout()
    }
    
    var top: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .top) }
        set { constraint(newValue, with: .top) }
    }
    
    var bottom: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .bottom) }
        set { constraint(newValue, with: .bottom) }
    }
    
    var left: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .left) }
        set { constraint(newValue, with: .left) }
    }
    
    var right: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .right) }
        set { constraint(newValue, with: .right) }
    }
    
    var centerX: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .centerX) }
        set { constraint(newValue, with: .centerX) }
    }
    
    var centerY: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .centerY) }
        set { constraint(newValue, with: .centerY) }
    }
    
    var height: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .height) }
        set { constraint(newValue, with: .height) }
    }
    
    var width: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .width) }
        set { constraint(newValue, with: .width) }
    }
    
    private func constraint(_ modifier: LayoutModifier, with layoutAttribute: NSLayoutAttribute) {
        let constraint = modifier.constraint(view: view, layoutAttribute: layoutAttribute)
        constraint.isActive = true
    }
}

protocol LayoutModifier {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint
    func add(_ constant: CGFloat) -> LayoutModifier
    func multiply(by multiplier: CGFloat) -> LayoutModifier
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier
}

extension UIView {
    var layout: Layout {
        return Layout(view: self)
    }
    
    fileprivate func prepareForAutolayout() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// MARK: - Operations
prefix operator <=
prefix operator >=
infix operator -->

func + (modifier: LayoutModifier, constant: CGFloat) -> LayoutModifier {
    return modifier.add(constant)
}

func - (modifier: LayoutModifier, constant: CGFloat) -> LayoutModifier {
    return modifier.add(-constant)
}

func * (modifier: LayoutModifier, multiplier: CGFloat) -> LayoutModifier {
    return modifier.multiply(by: multiplier)
}

func / (modifier: LayoutModifier, multiplier: CGFloat) -> LayoutModifier {
    return modifier.multiply(by: 1 / multiplier)
}

prefix func <= (modifier: LayoutModifier) -> LayoutModifier {
    return modifier.setRelation(.lessThanOrEqual)
}

prefix func >= (modifier: LayoutModifier) -> LayoutModifier {
    return modifier.setRelation(.greaterThanOrEqual)
}


func --> (modifier: LayoutModifier, constraint: inout NSLayoutConstraint) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, constraint: &constraint)
}

func --> (modifier: LayoutModifier, constraint: inout NSLayoutConstraint?) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, optionalConstraint: &constraint)
}

func --> (modifier: LayoutModifier, constraint: inout NSLayoutConstraint!) -> LayoutModifier {
    return LayoutConstraintSetter(original: modifier, forcedOptionalConstraint: &constraint)
}

// MARK: - Constants

protocol CGFloatConvertible {
    var cgFloat: CGFloat { get }
}

extension CGFloat: CGFloatConvertible, LayoutModifier {
    var cgFloat: CGFloat { return self }
}

extension Int: CGFloatConvertible, LayoutModifier {
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Double: CGFloatConvertible, LayoutModifier {
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension LayoutModifier where Self: CGFloatConvertible {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: layoutAttribute,
                                  relatedBy: .equal,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 0,
                                  constant: cgFloat)
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        return cgFloat + constant
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return cgFloat * multiplier
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> LayoutModifier {
        return LayoutConstant(constant: self.cgFloat, relation: relation)
    }
}

private struct LayoutConstant: LayoutModifier {
    var constant: CGFloat
    var relation: NSLayoutRelation
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: layoutAttribute,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 0,
                                  constant: constant)
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
}

private struct LayoutAttribute: LayoutModifier {
    let view: UIView
    let attribute: NSLayoutAttribute
    fileprivate(set) var constant: CGFloat
    fileprivate(set) var multiplier: CGFloat
    fileprivate(set) var relation: NSLayoutRelation
    
    fileprivate init(view: UIView, attribute: NSLayoutAttribute, relation: NSLayoutRelation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1) {
        self.view = view
        self.attribute = attribute
        self.relation = relation
        self.constant = constant
        self.multiplier = multiplier
    }
    
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: layoutAttribute,
                                  relatedBy: .equal,
                                  toItem: self.view,
                                  attribute: attribute,
                                  multiplier: multiplier,
                                  constant: constant)
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
}

private class LayoutConstraintSetter: LayoutModifier {
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
}

extension NSLayoutConstraint {
    static var empty: NSLayoutConstraint { return NSLayoutConstraint() }
}
