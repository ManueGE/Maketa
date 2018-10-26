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
    fileprivate let view: View
    fileprivate let kind: Kind
    
    fileprivate var edges: [Edge]
    fileprivate var insets = UIEdgeInsets.zero
    fileprivate var relation = Maketa.Defaults.relation
    fileprivate var priority = Maketa.Defaults.priority
    fileprivate var constraintsPointer: MultiTypePointer<EdgesConstraints>?
    
    fileprivate init(view: View, kind: Kind, edges: [Edge]) {
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
        let mkt = view.mkt
        var constraint = NSLayoutConstraint.empty
        let relation = edges.relation
        let priority = edges.priority
		let targetView = edges.view.target(for: view)
        
        switch (self, edges.kind) {
        // Left
        case (.left, .edges):
            assign(&mkt.left,
                to: ((targetView.mkt.left - edges.insets.left) & priority) => constraint,
                with: relation)
            
        case (.left, .margins):
            assign(&mkt.leftMargin,
                to: ((targetView.mkt.leftMargin - edges.insets.left) & priority) => constraint,
                with: relation)
            
        // Right
        case (.right, .edges):
            assign(&mkt.right,
                to: ((targetView.mkt.right + edges.insets.right) & priority) => constraint,
                with: relation)
            
        case (.right, .margins):
            assign(&mkt.rightMargin,
                to: ((targetView.mkt.rightMargin + edges.insets.right) & priority) => constraint,
                with: relation)
            
        // Leading
        case (.leading, .edges):
            assign(&mkt.leading,
                to: ((targetView.mkt.leading - edges.insets.left) & priority) => constraint,
                with: relation)
            
        case (.leading, .margins):
            assign(&mkt.leadingMargin,
                to: ((targetView.mkt.leadingMargin - edges.insets.left) & priority) => constraint,
                with: relation)
            
        // Trailing
        case (.trailing, .edges):
            assign(&mkt.trailing,
                to: ((targetView.mkt.trailing + edges.insets.right) & priority) => constraint,
                with: relation)
            
        case (.trailing, .margins):
            assign(&mkt.trailingMargin,
                to: ((targetView.mkt.trailingMargin + edges.insets.right) & priority) => constraint,
                with: relation)
            
        // Top
        case (.top, .edges):
            assign(&mkt.top,
                to: ((targetView.mkt.top - edges.insets.top) & priority) => constraint,
                with: relation)
            
        case (.top, .margins):
            assign(&mkt.topMargin,
                to: ((targetView.mkt.topMargin - edges.insets.top) & priority) => constraint,
                with: relation)
            
        // Bottom
        case (.bottom, .edges):
            assign(&mkt.bottom,
                to: ((targetView.mkt.bottom + edges.insets.bottom) & priority) => constraint,
                with: relation)
            
        case (.bottom, .margins):
            assign(&mkt.bottomMargin,
                to: ((targetView.mkt.bottomMargin + edges.insets.bottom) & priority) => constraint,
                with: relation)
        }
        
        return constraint
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
public func => (edges: Edges, constraints: inout EdgesConstraints) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(&constraints)
    return edges
}

/// Saves the constraints added when the edge is applied into the given pointer
public func => (edges: Edges, constraints: inout EdgesConstraints?) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(withOptional: &constraints)
    return edges
}

// MARK: - Maketa extension

public extension Maketa {
    
    /// returns the edges of the receiver (left, right, top, bottom)
    public var edges: Edges {
        get {
            return Edges(view: .view(view), kind: .edges, edges: Edge.all)
        }
        set {
            setEdges(newValue)
        }
    }
    
    /// returns the edges of the receiver relative to the view margins (left, right, top, bottom)
    public var margins: Edges {
        return Edges(view: .view(view), kind: .margins, edges: Edge.all)
    }
    
    /// returns the edges of the receiver using the interface layout direction (leading, trailing, top, bottom)
    public var layoutDirectionEdges: Edges {
        return Edges(view: .view(view), kind: .edges, edges: Edge.allRelativeToLayoutDirection)
    }
    /// returns the margins of the receiver using the interface layout direction (leading, trailing, top, bottom)
    public var layoutDirectionMargins: Edges {
        return Edges(view: .view(view), kind: .margins, edges: Edge.allRelativeToLayoutDirection)
    }
    
    private func setEdges(_ newValue: Edges) {
		view.preparedForAutolayout()
		
        let dictionary = newValue.edges.reduce([Edge: NSLayoutConstraint]()) { (result, edge) -> [Edge: NSLayoutConstraint] in
            var result = result
            result[edge] = edge.constraint(view: view, with: newValue)
            return result
        }
        
        let constraints = EdgesConstraints(dictionary: dictionary)
        newValue.constraintsPointer?.setPointee(constraints)
    }
}

// MARK: - Superview extension

public extension Superview {
	
	/// returns the edges of the receiver (left, right, top, bottom)
	public static var edges: Edges {
		return Edges(view: .superview, kind: .edges, edges: Edge.all)
	}
	
	/// returns the edges of the receiver relative to the view margins (left, right, top, bottom)
	public static var margins: Edges {
		return Edges(view: .superview, kind: .margins, edges: Edge.all)
	}
	
	/// returns the edges of the receiver using the interface layout direction (leading, trailing, top, bottom)
	public static var layoutDirectionEdges: Edges {
		return Edges(view: .superview, kind: .edges, edges: Edge.allRelativeToLayoutDirection)
	}
	/// returns the margins of the receiver using the interface layout direction (leading, trailing, top, bottom)
	public static var layoutDirectionMargins: Edges {
		return Edges(view: .superview, kind: .margins, edges: Edge.allRelativeToLayoutDirection)
	}
}

/// The object returned when the edge constraints are assigned.
public struct EdgesConstraints {
    
    /// The constraint added for the left edge, if any
    public let left: NSLayoutConstraint?
    
    /// The constraint added for the right edge, if any
    public let right: NSLayoutConstraint?
    
    /// The constraint added for the leading edge, if any
    public let leading: NSLayoutConstraint?
    
    /// The constraint added for the trailing edge, if any
    public let trailing: NSLayoutConstraint?
    
    /// The constraint added for the top edge, if any
    public let top: NSLayoutConstraint?
    
    /// The constraint added for the bottom edge, if any
    public let bottom: NSLayoutConstraint?
    
    /// Creates a new instance
    public init() {
        self.left = nil
        self.right = nil
        self.leading = nil
        self.trailing = nil
        self.top = nil
        self.bottom = nil
    }
    
    fileprivate init(dictionary: [Edge: NSLayoutConstraint]) {
        self.left = dictionary[.left]
        self.right = dictionary[.right]
        self.leading = dictionary[.leading]
        self.trailing = dictionary[.trailing]
        self.top = dictionary[.top]
        self.bottom = dictionary[.bottom]
    }
}
