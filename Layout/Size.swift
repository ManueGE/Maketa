//
//  Size.swift
//  Layout
//
//  Created by Manuel García-Estañ on 12/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

public protocol Size {
    @discardableResult
    func constraints(for view: UIView) -> [NSLayoutConstraint]
}

// MARK: - Constants
extension CGFloat: Size {}
extension Float: Size {}
extension Int: Size {}
extension Double: Size {}

public extension Size where Self: LayoutCGFloatConvertible {
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        let size = CGSize(width: layoutCGFloat, height: layoutCGFloat)
        return size.constraints(for: view)
    }
}

// MARK: - CGSize
extension CGSize: Size {
    public func constraints(for view: UIView) -> [NSLayoutConstraint] {
        var wConstraint = NSLayoutConstraint.empty
        view.layout.width = width => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        view.layout.height = height => hConstraint
        
        return [wConstraint, hConstraint]
    }
}

// MARK: - Other view
private struct ViewSize: Size {
    let view: UIView
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        var wConstraint = NSLayoutConstraint.empty
        view.layout.width = self.view.layout.width => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        view.layout.height = self.view.layout.height => hConstraint
        
        return [wConstraint, hConstraint]
    }
}

// MARK: - Setter
private struct SizeConstraintSetter: Size {
    fileprivate(set) var original: Size
    fileprivate let constraintPointer: MultiTypePointer<[NSLayoutConstraint]>
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = original.constraints(for: view)
        constraintPointer.setPointee(constraints)
        return constraints
    }
}

// MARK: - Operators
public func => (size: Size, constraints: inout [NSLayoutConstraint]) -> Size {
    let pointer = MultiTypePointer(&constraints)
    return SizeConstraintSetter(original: size, constraintPointer: pointer)
}

public func => (size: Size, constraints: inout [NSLayoutConstraint]?) -> Size {
    let pointer = MultiTypePointer(withOptional: &constraints)
    return SizeConstraintSetter(original: size, constraintPointer: pointer)
}

public func => (size: Size, constraints: inout [NSLayoutConstraint]!) -> Size {
    let pointer = MultiTypePointer(withForcedUnwrapped: &constraints)
    return SizeConstraintSetter(original: size, constraintPointer: pointer)
}

// MARK: - Layout extension
public extension Layout {
    public var size: Size {
        get { return ViewSize(view: view) }
        set { newValue.constraints(for: view) }
    }
}
