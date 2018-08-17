//
//  AttributeModifier.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

/// A protocol that must implement objects that can modify a layout attribute of a view
public protocol AttributeModifier {
    /// returns the constraint that will be applied to modify the given attribute of the given view
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint
    
    /// returns a new `AttributeModifier` which is the result of adding a constant to the receiver
    func add(_ constant: CGFloat) -> AttributeModifier
    
    /// returns a new `AttributeModifier` which is the result of mutiplying the reciver by a multiplier
    func multiply(by multiplier: CGFloat) -> AttributeModifier
    
    /// returns a new `AttributeModifier` which is the result of assigning a `NSLayoutRelation` to the receiver
    func setRelation(_ relation: NSLayoutRelation) -> AttributeModifier
    
    /// returns a new `AttributeModifier` which is the result of assigning a `UILayoutPriority` to the receiver
    func setPriority(_ priority: UILayoutPriority) -> AttributeModifier
}

extension Maketa {
    // MARK: Raw attributes
    
    /// The left side of the object’s alignment rectangle.
    public var left: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .left) }
        set { constraint(newValue, with: .left) }
    }
    
    /// The right side of the object’s alignment rectangle.
    public var right: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .right) }
        set { constraint(newValue, with: .right) }
    }
    
    /// The top of the object’s alignment rectangle.
    public var top: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .top) }
        set { constraint(newValue, with: .top) }
    }
    
    /// The bottom of the object’s alignment rectangle.
    public var bottom: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .bottom) }
        set { constraint(newValue, with: .bottom) }
    }
    
    /// The leading edge of the object’s alignment rectangle.
    public var leading: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .leading) }
        set { constraint(newValue, with: .leading) }
    }
    
    /// The trailing edge of the object’s alignment rectangle.
    public var trailing: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .trailing) }
        set { constraint(newValue, with: .trailing) }
    }
    
    /// The width of the object’s alignment rectangle.
    public var width: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .width) }
        set { constraint(newValue, with: .width) }
    }
    
    /// The height of the object’s alignment rectangle.
    public var height: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .height) }
        set { constraint(newValue, with: .height) }
    }
    
    /// The center along the x-axis of the object’s alignment rectangle.
    public var centerX: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .centerX) }
        set { constraint(newValue, with: .centerX) }
    }
    
    /// The center along the y-axis of the object’s alignment rectangle.
    public var centerY: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .centerY) }
        set { constraint(newValue, with: .centerY) }
    }
    
    /// The object’s baseline. For objects with more than one line of text, this is the baseline for the bottommost line of text.
    public var lastBaseline: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .lastBaseline) }
        set { constraint(newValue, with: .lastBaseline) }
    }
    
    /// The object’s baseline. For objects with more than one line of text, this is the baseline for the topmost line of text.
    public var firstBaseline: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .firstBaseline) }
        set { constraint(newValue, with: .firstBaseline) }
    }
    
    /// The object’s left margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
    public var leftMargin: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .leftMargin) }
        set { constraint(newValue, with: .leftMargin) }
    }
    
    /// The object’s right margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
    public var rightMargin: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .rightMargin) }
        set { constraint(newValue, with: .rightMargin) }
    }
    
    /// The object’s top margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
    public var topMargin: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .topMargin) }
        set { constraint(newValue, with: .topMargin) }
    }
    
    /// The object’s bottom margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
    public var bottomMargin: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .bottomMargin) }
        set { constraint(newValue, with: .bottomMargin) }
    }
    
    /// The object’s leading margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
    public var leadingMargin: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .leadingMargin) }
        set { constraint(newValue, with: .leadingMargin) }
    }
    
    /// The object’s trailing margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
    public var trailingMargin: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .trailingMargin) }
        set { constraint(newValue, with: .trailingMargin) }
    }
    
    /// The center along the x-axis between the object’s left and right margin. For `UIView` objects, the margins are defined by their `layoutMargins`     `property`.
    public var centerXWithinMargins: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .centerXWithinMargins) }
        set { constraint(newValue, with: .centerXWithinMargins) }
    }
    
    /// The center along the y-axis between the object’s left and right margin. For `UIView` objects, the margins are defined by their `layoutMargins`     `property`.
    public var centerYWithinMargins: AttributeModifier {
        get { return LayoutAttribute(view: view, attribute: .centerYWithinMargins) }
        set { constraint(newValue, with: .centerYWithinMargins) }
    }
    
    // MARK: Additional attributes
    
    /// The relationship between the width and the height of the object.
    public var aspectRatio: CGFloat {
        get {
            view.layoutIfNeeded()
            return view.frame.width / view.frame.height
        }
        set { width = newValue * height }
    }
    
    // MARK: - Helper
    
    private func constraint(_ modifier: AttributeModifier, with layoutAttribute: NSLayoutAttribute) {
        modifier.constraint(view: view, layoutAttribute: layoutAttribute).activated()
    }
}

func assign(_ modifier: inout AttributeModifier, to value: AttributeModifier, with relation: NSLayoutRelation) {
    switch relation {
    case .equal:
        modifier = value
    case .lessThanOrEqual:
        modifier < value
    case .greaterThanOrEqual:
        modifier > value
    }
}
