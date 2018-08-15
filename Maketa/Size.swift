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
    func setRelation(_ relation: NSLayoutRelation) -> Size
    func setPriority(_ priority: UILayoutPriority) -> Size
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
    
    public func setRelation(_ relation: NSLayoutRelation) -> Size {
        let size = CGSize(width: layoutCGFloat, height: layoutCGFloat)
        return FixedSize(size: size, relation: relation, priority: Maketa.Defaults.priority)
    }
    
    public func setPriority(_ priority: UILayoutPriority) -> Size {
        let size = CGSize(width: layoutCGFloat, height: layoutCGFloat)
        return FixedSize(size: size, relation: Maketa.Defaults.relation, priority: priority)
    }
}

// MARK: - CGSize
extension CGSize: Size {
    public func constraints(for view: UIView) -> [NSLayoutConstraint] {
        let size = FixedSize(size: self, relation: Maketa.Defaults.relation, priority: Maketa.Defaults.priority)
        return size.constraints(for: view)
    }
    
    public func add(_ offset: UIOffset) -> Size {
        return CGSize(width: width + offset.horizontal, height: height + offset.vertical)
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
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
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
        
        return [wConstraint, hConstraint]
    }
    
    func add(_ offset: UIOffset) -> Size {
        let size = CGSize(width: self.size.width + offset.horizontal, height: self.size.height + offset.vertical)
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
    private(set) var relation = Maketa.Defaults.relation
    private(set) var priority = Maketa.Defaults.priority
    
    init(view: UIView) {
        self.view = view
    }
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        var wConstraint = NSLayoutConstraint.empty
        let wValue = ((self.view.mkt.width + offset.horizontal) & priority) => wConstraint
        
        var hConstraint = NSLayoutConstraint.empty
        let hValue = ((self.view.mkt.height + offset.vertical) & priority) => hConstraint
        
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
        
        return [wConstraint, hConstraint]
    }
    
    func add(_ offset: UIOffset) -> Size {
        var size = self
        size.offset = UIOffset(horizontal: self.offset.horizontal + offset.horizontal, vertical: self.offset.vertical + offset.vertical)
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
    fileprivate let constraintPointer: MultiTypePointer<[NSLayoutConstraint]>
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = original.constraints(for: view)
        constraintPointer.setPointee(constraints)
        return constraints
    }
    
    func add(_ offset: UIOffset) -> Size { fatalError("Can't modify a `Size` after it is assigned") }
    
    func setRelation(_ relation: NSLayoutRelation) -> Size {
        var value = self
        value.original = original.setRelation(relation)
        return value
    }
    
    func setPriority(_ priority: UILayoutPriority) -> Size { fatalError("Can't modify a `Size` after it is assigned") }
}

// MARK: - Operators
public func < (left: inout Size, right: Size) {
    left = right.setRelation(.lessThanOrEqual)
}

public func > (left: inout Size, right: Size) {
    left = right.setRelation(.greaterThanOrEqual)
}

public func & (modifier: Size, priority: UILayoutPriority) -> Size {
    return modifier.setPriority(priority)
}

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
