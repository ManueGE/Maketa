//
//  Size.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 12/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

/// A protocol that must implement objects that can modify the constraint associated with the size of a view
public protocol Size {
    /// returns the constraints that will be applied to modify the size of the given view
    @discardableResult
    func constraints(for view: UIView) -> SizeConstraints
    
    /// returns a new `Size` which is the result of adding a `UIOffset` to the receiver
    func add(_ offset: UIOffset) -> Size
    
    /// returns a new `Size` which is the result of mutiplying the reciver by a multiplier
    func multiply(by multiplier: CGFloat) -> Size
    
    /// returns a new `Size` which is the result of assigning a `NSLayoutRelation` to the receiver
    func setRelation(_ relation: NSLayoutRelation) -> Size
    
    /// returns a new `Size` which is the result of assigning a `UILayoutPriority` to the receiver
    func setPriority(_ priority: UILayoutPriority) -> Size
}

// MARK: - Constants
extension CGFloat: Size {}
extension Float: Size {}
extension Int: Size {}
extension Double: Size {}

public extension Size where Self: MaketaCGFloatConvertible {
    func constraints(for view: UIView) -> SizeConstraints {
        let size = CGSize(width: mktCGFloat, height: mktCGFloat)
        return size.constraints(for: view)
    }
    
    func add(_ offset: UIOffset) -> Size {
        return CGSize(width: mktCGFloat + offset.horizontal, height: mktCGFloat + offset.vertical)
    }
    
    func multiply(by multiplier: CGFloat) -> Size {
        return CGSize(width: mktCGFloat * multiplier, height: mktCGFloat * multiplier)
    }
    
    public func setRelation(_ relation: NSLayoutRelation) -> Size {
        let size = CGSize(width: mktCGFloat, height: mktCGFloat)
        return FixedSize(size: size, relation: relation, priority: Maketa.Defaults.priority)
    }
    
    public func setPriority(_ priority: UILayoutPriority) -> Size {
        let size = CGSize(width: mktCGFloat, height: mktCGFloat)
        return FixedSize(size: size, relation: Maketa.Defaults.relation, priority: priority)
    }
}

// MARK: - CGSize
extension CGSize: Size {
    public func constraints(for view: UIView) -> SizeConstraints {
        let size = FixedSize(size: self, relation: Maketa.Defaults.relation, priority: Maketa.Defaults.priority)
        return size.constraints(for: view)
    }
    
    public func add(_ offset: UIOffset) -> Size {
        return CGSize(width: width + offset.horizontal, height: height + offset.vertical)
    }
    
    public func multiply(by multiplier: CGFloat) -> Size {
        return CGSize(width: width * multiplier, height: height * multiplier)
    }
    
    public func setRelation(_ relation: NSLayoutRelation) -> Size {
        return FixedSize(size: self, relation: relation, priority: Maketa.Defaults.priority)
    }
    
    public func setPriority(_ priority: UILayoutPriority) -> Size {
        return FixedSize(size: self, relation: Maketa.Defaults.relation, priority: priority)
    }
}

// MARK: - FixedSize
private struct FixedSize: Size {
    let size: CGSize
    let relation: NSLayoutRelation
    let priority: UILayoutPriority
    
    func constraints(for view: UIView) -> SizeConstraints {
        var wConstraint = NSLayoutConstraint.empty
        let wValue = (size.width & priority) => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        let hValue = (size.height & priority) => hConstraint
        
        switch relation {
        case .equal:
            view.mkt.width = wValue
            view.mkt.height = hValue
        case .lessThanOrEqual:
            view.mkt.width < wValue
            view.mkt.height < hValue
        case .greaterThanOrEqual:
            view.mkt.width > wValue
            view.mkt.height > hValue
        }
        
        return SizeConstraints(width: wConstraint, height: hConstraint)
    }
    
    func add(_ offset: UIOffset) -> Size {
        let size = CGSize(width: self.size.width + offset.horizontal, height: self.size.height + offset.vertical)
        return FixedSize(size: size, relation: relation, priority: priority)
    }
    
    func multiply(by multiplier: CGFloat) -> Size {
        let size = CGSize(width: self.size.width * multiplier, height: self.size.height * multiplier)
        return FixedSize(size: size, relation: relation, priority: priority)
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> Size {
        return FixedSize(size: size, relation: relation, priority: priority)
    }
    
    func setPriority(_ priority: UILayoutPriority) -> Size {
        return FixedSize(size: size, relation: relation, priority: priority)
    }
}

// MARK: - Other view
private struct ViewSize: Size {
    let view: UIView
    var offset: UIOffset = UIOffset(horizontal: 0, vertical: 0)
    var multiplier: CGFloat = 1
    private(set) var relation = Maketa.Defaults.relation
    private(set) var priority = Maketa.Defaults.priority
    
    init(view: UIView) {
        self.view = view
    }
    
    func constraints(for view: UIView) -> SizeConstraints {
        var wConstraint = NSLayoutConstraint.empty
        let wValue = ((self.view.mkt.width * multiplier + offset.horizontal) & priority) => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        let hValue = ((self.view.mkt.height * multiplier + offset.vertical) & priority) => hConstraint
        
        switch relation {
        case .equal:
            view.mkt.width = wValue
            view.mkt.height = hValue
        case .lessThanOrEqual:
            view.mkt.width < wValue
            view.mkt.height < hValue
        case .greaterThanOrEqual:
            view.mkt.width > wValue
            view.mkt.height > hValue
        }
        
        return SizeConstraints(width: wConstraint, height: hConstraint)
    }
    
    func add(_ offset: UIOffset) -> Size {
        var size = self
        size.offset = UIOffset(horizontal: self.offset.horizontal + offset.horizontal, vertical: self.offset.vertical + offset.vertical)
        return size
    }
    
    func multiply(by multiplier: CGFloat) -> Size {
        var size = self
        size.multiplier = multiplier
        return size
    }
    
    func setRelation(_ relation: NSLayoutRelation) -> Size {
        var value = self
        value.relation = relation
        return value
    }
    
    func setPriority(_ priority: UILayoutPriority) -> Size {
        var value = self
        value.priority = priority
        return value
    }
}

// MARK: - Setter
private struct SizeConstraintSetter: Size {
    fileprivate(set) var original: Size
    fileprivate let constraintPointer: MultiTypePointer<SizeConstraints>
    
    func constraints(for view: UIView) -> SizeConstraints {
        let constraints = original.constraints(for: view)
        constraintPointer.setPointee(constraints)
        return constraints
    }
    
    func add(_ offset: UIOffset) -> Size { fatalError("Can't modify a `Size` after it is assigned") }
    
    func multiply(by multiplier: CGFloat) -> Size { fatalError("Can't modify a `Size` after it is assigned") }
    
    func setRelation(_ relation: NSLayoutRelation) -> Size {
        var value = self
        value.original = original.setRelation(relation)
        return value
    }
    
    func setPriority(_ priority: UILayoutPriority) -> Size { fatalError("Can't modify a `Size` after it is assigned") }
}

// MARK: - Operators

/// Set the size on the left to the size on the right with a `.lessThanOrEqual` relation.
public func < (left: inout Size, right: Size) {
    left = right.setRelation(.lessThanOrEqual)
}

// Set the size on the left to the size on the right with a `.greaterThanOrEqual` relation.
public func > (left: inout Size, right: Size) {
    left = right.setRelation(.greaterThanOrEqual)
}

/// Set the priority of the given size to the given priority
public func & (modifier: Size, priority: UILayoutPriority) -> Size {
    return modifier.setPriority(priority)
}

/// Adds an offset to the given size
public func + (size: Size, offset: UIOffset) -> Size {
    return size.add(offset)
}

/// Adds an offset to the given size
public func + (offset: UIOffset, size: Size) -> Size {
    return size + offset
}

/// Substract an offset from the given size
public func - (size: Size, offset: UIOffset) -> Size {
    return size + UIOffset(horizontal: -offset.horizontal, vertical: -offset.vertical)
}

/// Adds an offset to the given size
public func + (size: Size, constant: MaketaCGFloatConvertible) -> Size {
    return size + UIOffset(horizontal: constant.mktCGFloat, vertical: constant.mktCGFloat)
}

/// Adds an offset to the given size
public func + (constant: MaketaCGFloatConvertible, size: Size) -> Size {
    return size + constant
}

/// Substract an offset from the given size
public func - (size: Size, constant: MaketaCGFloatConvertible) -> Size {
    return size + -constant.mktCGFloat
}

/// Multiplies the size by the given multiplier
public func * (size: Size, multiplier: MaketaCGFloatConvertible) -> Size {
    return size.multiply(by: multiplier.mktCGFloat)
}

/// Multiplies the size by the given multiplier
public func * (multiplier: MaketaCGFloatConvertible, size: Size) -> Size {
    return size * multiplier
}

/// Divides the size by the given divider
public func / (size: Size, divider: MaketaCGFloatConvertible) -> Size {
    return size * (1 / divider.mktCGFloat)
}

/// Saves the constraints added when the center is applied into the given pointer
public func => (size: Size, constraints: inout SizeConstraints) -> Size {
    let pointer = MultiTypePointer(&constraints)
    return SizeConstraintSetter(original: size, constraintPointer: pointer)
}

/// Saves the constraints added when the center is applied into the given pointer
public func => (size: Size, constraints: inout SizeConstraints?) -> Size {
    let pointer = MultiTypePointer(withOptional: &constraints)
    return SizeConstraintSetter(original: size, constraintPointer: pointer)
}

/// Saves the constraints added when the center is applied into the given pointer
public func => (size: Size, constraints: inout SizeConstraints!) -> Size {
    let pointer = MultiTypePointer(withForcedUnwrapped: &constraints)
    return SizeConstraintSetter(original: size, constraintPointer: pointer)
}

/// The object returned when the size constraints are assigned.
public struct SizeConstraints {
    
    /// The constraint added for the width attribute
    public let width: NSLayoutConstraint
    
    /// The constraint added for the height attribute
    public let height: NSLayoutConstraint
    
    /// An array with all the constraints. The order will be width, height
    public var array: [NSLayoutConstraint] { return [width, height] }
    
    /// Creates a new instance
    public init() {
        width = .empty
        height = .empty
    }
    
    fileprivate init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
        self.width = width
        self.height = height
    }
}

// MARK: - Layout extension
public extension Maketa {
    
    /// returns the size of the receiver
    public var size: Size {
        get { return ViewSize(view: view) }
        set { newValue.constraints(for: view) }
    }
}
