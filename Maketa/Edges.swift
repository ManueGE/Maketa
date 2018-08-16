//
//  Edges.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

/// A struct used to match the constraints associated to the edges of a `UIView` to the edges of another `UIView`.
public struct Edges {
    fileprivate enum Kind {
        case edges, margins
    }
    fileprivate let view: UIView
    fileprivate let kind: Kind
    
    fileprivate var edges: [Edge]
    fileprivate var insets = UIEdgeInsets.zero
    fileprivate var relation = Maketa.Defaults.relation
    fileprivate var priority = Maketa.Defaults.priority
    fileprivate var constraintsPointer: MultiTypePointer<[NSLayoutConstraint]>?
    
    fileprivate init(view: UIView, kind: Kind, edges: [Edge]) {
        self.view = view
        self.kind = kind
        self.edges = edges
    }
}

/// Each one of the possible edges of a `UIView`.
public enum Edge: Equatable {
    case left, right, leading, trailing, top, bottom
    static fileprivate let all = [Edge.left, .right, .top, .bottom]
    static fileprivate let allRelativeToLayoutDirection = [Edge.leading, .trailing, .top, .bottom]
    
    fileprivate func constraint(view: UIView, with edges: Edges) -> NSLayoutConstraint {
        let layout = view.mkt
        var constraint = NSLayoutConstraint.empty
        let relation = edges.relation
        let priority = edges.priority
        
        switch (self, edges.kind) {
        // Left
        case (.left, .edges):
            set(&layout.left,
                to: ((edges.view.mkt.left - edges.insets.left) & priority) => constraint,
                with: relation)
            
        case (.left, .margins):
            set(&layout.leftMargin,
                to: ((edges.view.mkt.leftMargin - edges.insets.left) & priority) => constraint,
                with: relation)
            
        // Right
        case (.right, .edges):
            set(&layout.right,
                to: ((edges.view.mkt.right + edges.insets.right) & priority) => constraint,
                with: relation)
            
        case (.right, .margins):
            set(&layout.rightMargin,
                to: ((edges.view.mkt.rightMargin + edges.insets.right) & priority) => constraint,
                with: relation)
            
        // Leading
        case (.leading, .edges):
            set(&layout.leading,
                to: ((edges.view.mkt.leading - edges.insets.left) & priority) => constraint,
                with: relation)
            
        case (.leading, .margins):
            set(&layout.leadingMargin,
                to: ((edges.view.mkt.leadingMargin - edges.insets.left) & priority) => constraint,
                with: relation)
            
        // Trailing
        case (.trailing, .edges):
            set(&layout.trailing,
                to: ((edges.view.mkt.trailing + edges.insets.right) & priority) => constraint,
                with: relation)
            
        case (.trailing, .margins):
            set(&layout.trailingMargin,
                to: ((edges.view.mkt.trailingMargin + edges.insets.right) & priority) => constraint,
                with: relation)
            
        // Top
        case (.top, .edges):
            set(&layout.top,
                to: ((edges.view.mkt.top - edges.insets.top) & priority) => constraint,
                with: relation)
            
        case (.top, .margins):
            set(&layout.topMargin,
                to: ((edges.view.mkt.topMargin - edges.insets.top) & priority) => constraint,
                with: relation)
            
        // Bottom
        case (.bottom, .edges):
            set(&layout.bottom,
                to: ((edges.view.mkt.bottom + edges.insets.bottom) & priority) => constraint,
                with: relation)
            
        case (.bottom, .margins):
            set(&layout.bottomMargin,
                to: ((edges.view.mkt.bottomMargin + edges.insets.bottom) & priority) => constraint,
                with: relation)
        }
        
        return constraint
    }
    
    private func set(_ modifier: inout AttributeModifier, to value: AttributeModifier, with relation: NSLayoutRelation) {
        switch relation {
        case .equal:
            modifier = value
        case .lessThanOrEqual:
            modifier < value
        case .greaterThanOrEqual:
            modifier > value
        }
    }
}

// MARK: - Operators

/// Set the edges on the left to the edges on the right with a `.lessThanOrEqual` relation.
public func < (left: inout Edges, right: Edges) {
    var newValue = right
    newValue.relation = .lessThanOrEqual
    left = newValue
}

/// Set the edges on the left to the edges on the right with a `.greaterThanOrEqual` relation.
public func > (left: inout Edges, right: Edges) {
    var newValue = right
    newValue.relation = .greaterThanOrEqual
    left = newValue
}

/// Set the priority of the given edges to the given priority
public func & (edges: Edges, priority: UILayoutPriority) -> Edges {
    var newValue = edges
    newValue.priority = priority
    return newValue
}

/// Excludes the edge on the right from the edges on the left
public func - (edges: Edges, excluded: Edge) -> Edges {
    guard let index = edges.edges.index(of: excluded) else { return edges }
    var edges = edges
    edges.edges.remove(at: index)
    return edges
}

/// Adds an inset to the given edge.
public func + (edges: Edges, insets: UIEdgeInsets) -> Edges {
    var edges = edges
    edges.insets.left += insets.left
    edges.insets.right += insets.right
    edges.insets.top += insets.top
    edges.insets.bottom += insets.bottom
    return edges
}

/// Substracts an inset from the given edge.
public func - (edges: Edges, insets: UIEdgeInsets) -> Edges {
    return edges + UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right)
}

/// Adds an inset to the given edge.
public func + (edges: Edges, inset: MaketaCGFloatConvertible) -> Edges {
    let value = inset.mktCGFloat
    let insets = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    return edges + insets
}

/// Substracts an inset from the given edge.
public func - (edges: Edges, inset: MaketaCGFloatConvertible) -> Edges {
    return edges + -inset.mktCGFloat
}

/// Saves the constraints added when the edge is applied into the given pointer
public func => (edges: Edges, constraints: inout [NSLayoutConstraint]) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(&constraints)
    return edges
}

/// Saves the constraints added when the edge is applied into the given pointer
public func => (edges: Edges, constraints: inout [NSLayoutConstraint]?) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(withOptional: &constraints)
    return edges
}

/// Saves the constraints added when the edge is applied into the given pointer
public func => (edges: Edges, constraints: inout [NSLayoutConstraint]!) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(withForcedUnwrapped: &constraints)
    return edges
}

// MARK: - Maketa extension

public extension Maketa {
    
    /// returns the edges of the receiver (left, right, top, bottom)
    public var edges: Edges {
        get {
            return Edges(view: view, kind: .edges, edges: Edge.all)
        }
        set {
            setEdges(newValue)
        }
    }
    
    /// returns the edges of the receiver relative to the view margins (left, right, top, bottom)
    public var margins: Edges {
        return Edges(view: view, kind: .margins, edges: Edge.all)
    }
    
    /// returns the edges of the receiver using the interface layout direction (leading, trailing, top, bottom)
    public var layoutDirectionEdges: Edges {
        return Edges(view: view, kind: .edges, edges: Edge.allRelativeToLayoutDirection)
    }
    /// returns the margins of the receiver using the interface layout direction (leading, trailing, top, bottom)
    public var layoutDirectionMargins: Edges {
        return Edges(view: view, kind: .margins, edges: Edge.allRelativeToLayoutDirection)
    }
    
    private func setEdges(_ newValue: Edges) {
        let constraints = newValue.edges.map { $0.constraint(view: view, with: newValue) }
        newValue.constraintsPointer?.setPointee(constraints)
    }
}
