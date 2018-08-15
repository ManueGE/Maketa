//
//  MaketaModifier.swift
//  Maketa
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

extension Layout {
    // MARK: Raw attributes
    
    public var left: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .left) }
        set { constraint(newValue, with: .left) }
    }
    
    public var right: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .right) }
        set { constraint(newValue, with: .right) }
    }
    
    public var top: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .top) }
        set { constraint(newValue, with: .top) }
    }
    
    public var bottom: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .bottom) }
        set { constraint(newValue, with: .bottom) }
    }
    
    public var leading: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .leading) }
        set { constraint(newValue, with: .leading) }
    }
    
    public var trailing: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .trailing) }
        set { constraint(newValue, with: .trailing) }
    }
    
    public var width: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .width) }
        set { constraint(newValue, with: .width) }
    }
    
    public var height: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .height) }
        set { constraint(newValue, with: .height) }
    }
    
    public var centerX: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .centerX) }
        set { constraint(newValue, with: .centerX) }
    }
    
    public var centerY: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .centerY) }
        set { constraint(newValue, with: .centerY) }
    }
    
    public var lastBaseline: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .lastBaseline) }
        set { constraint(newValue, with: .lastBaseline) }
    }
    
    public var firstBaseline: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .firstBaseline) }
        set { constraint(newValue, with: .firstBaseline) }
    }
    
    public var leftMargin: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .leftMargin) }
        set { constraint(newValue, with: .leftMargin) }
    }
    
    public var rightMargin: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .rightMargin) }
        set { constraint(newValue, with: .rightMargin) }
    }
    
    public var topMargin: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .topMargin) }
        set { constraint(newValue, with: .topMargin) }
    }
    
    public var bottomMargin: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .bottomMargin) }
        set { constraint(newValue, with: .bottomMargin) }
    }
    
    public var leadingMargin: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .leadingMargin) }
        set { constraint(newValue, with: .leadingMargin) }
    }
    
    public var trailingMargin: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .trailingMargin) }
        set { constraint(newValue, with: .trailingMargin) }
    }
    
    public var centerXWithinMargins: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .centerXWithinMargins) }
        set { constraint(newValue, with: .centerXWithinMargins) }
    }
    
    public var centerYWithinMargins: LayoutModifier {
        get { return LayoutAttribute(view: view, attribute: .centerYWithinMargins) }
        set { constraint(newValue, with: .centerYWithinMargins) }
    }
    
    // MARK: Additional attributes
    
    public var aspectRatio: CGFloat {
        get { return view.frame.width / view.frame.height }
        set { width = newValue * height }
    }
    
    // MARK: - Helper
    
    private func constraint(_ modifier: LayoutModifier, with layoutAttribute: NSLayoutAttribute) {
        modifier.constraint(view: view, layoutAttribute: layoutAttribute).activated()
    }
}
