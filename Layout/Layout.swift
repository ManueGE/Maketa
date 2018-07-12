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
        let constraint =  modifier.constraint(view: view, layoutAttribute: layoutAttribute)
        constraint.isActive = true
    }
}

protocol LayoutModifier {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint
    func add(_ constant: CGFloat) -> LayoutModifier
    func multiply(by multiplier: CGFloat) -> LayoutModifier
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

extension CGFloat: LayoutModifier {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: layoutAttribute,
                                  relatedBy: .equal,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 0,
                                  constant: self)
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        return self + constant
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return self * multiplier
    }
}

extension Int: LayoutModifier {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return CGFloat(self).constraint(view: view, layoutAttribute: layoutAttribute)
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        return CGFloat(self) + constant
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return CGFloat(self) * multiplier
    }
}

extension Double: LayoutModifier {
    func constraint(view: UIView, layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return CGFloat(self).constraint(view: view, layoutAttribute: layoutAttribute)
    }
    
    func add(_ constant: CGFloat) -> LayoutModifier {
        return CGFloat(self) + constant
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        return CGFloat(self) * multiplier
    }
}

struct LayoutAttribute: LayoutModifier {
    let view: UIView
    let attribute: NSLayoutAttribute
    fileprivate(set) var constant: CGFloat
    fileprivate(set) var multiplier: CGFloat
    
    fileprivate init(view: UIView, attribute: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1) {
        self.view = view
        self.attribute = attribute
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
        var attribute = self
        attribute.constant += constant
        return attribute
    }
    
    func multiply(by multiplier: CGFloat) -> LayoutModifier {
        var attribute = self
        attribute.multiplier *= multiplier
        return attribute
    }
}
