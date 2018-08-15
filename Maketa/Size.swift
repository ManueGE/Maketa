//
//  Size.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 12/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

public protocol Size {
    @discardableResult
    func constraints(for view: UIView) -> [NSLayoutConstraint]
    func add(_ offset: UIOffset) -> Size
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
    
    func add(_ offset: UIOffset) -> Size {
        return CGSize(width: layoutCGFloat + offset.horizontal, height: layoutCGFloat + offset.vertical)
    }
}

// MARK: - CGSize
extension CGSize: Size {
    public func constraints(for view: UIView) -> [NSLayoutConstraint] {
        var wConstraint = NSLayoutConstraint.empty
        view.mkt.width = width => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        view.mkt.height = height => hConstraint
        
        return [wConstraint, hConstraint]
    }
    
    public func add(_ offset: UIOffset) -> Size {
        return CGSize(width: width + offset.horizontal, height: height + offset.vertical)
    }
}

// MARK: - Other view
private struct ViewSize: Size {
    let view: UIView
    var offset: UIOffset = UIOffset(horizontal: 0, vertical: 0)
    
    init(view: UIView) {
        self.view = view
    }
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        var wConstraint = NSLayoutConstraint.empty
        view.mkt.width = (self.view.mkt.width + offset.horizontal) => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        view.mkt.height = (self.view.mkt.height + offset.vertical) => hConstraint
        
        return [wConstraint, hConstraint]
    }
    
    func add(_ offset: UIOffset) -> Size {
        var size = self
        size.offset = UIOffset(horizontal: self.offset.horizontal + offset.horizontal, vertical: self.offset.vertical + offset.vertical)
        return size
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
    
    func add(_ offset: UIOffset) -> Size { fatalError("Can't modify a `Size` after it is assigned") }
}

// MARK: - Operators
public func + (size: Size, offset: UIOffset) -> Size {
    return size.add(offset)
}

public func + (offset: UIOffset, size: Size) -> Size {
    return size + offset
}

public func - (size: Size, offset: UIOffset) -> Size {
    return size + UIOffset(horizontal: -offset.horizontal, vertical: -offset.vertical)
}

public func + (size: Size, constant: LayoutCGFloatConvertible) -> Size {
    return size + UIOffset(horizontal: constant.layoutCGFloat, vertical: constant.layoutCGFloat)
}

public func + (constant: LayoutCGFloatConvertible, size: Size) -> Size {
    return size + constant
}

public func - (size: Size, constant: LayoutCGFloatConvertible) -> Size {
    return size + -constant.layoutCGFloat
}

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
public extension Maketa {
    public var size: Size {
        get { return ViewSize(view: view) }
        set { newValue.constraints(for: view) }
    }
}
