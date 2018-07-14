//
//  Edges.swift
//  Layout
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public struct Edges {
    fileprivate let view: UIView
    fileprivate var edges = Edge.all
    fileprivate var insets = UIEdgeInsets.zero
    fileprivate var isRelativeToMargins = false
    fileprivate var useLeadingAndTraling = false
    fileprivate var constraintsPointer: MultiTypePointer<[NSLayoutConstraint]>?
    
    fileprivate init(view: UIView) {
        self.view = view
    }
    
    public var margins: Edges {
        var edges = self
        edges.isRelativeToMargins = true
        return edges
    }
    
    public var relativeToLeadingAndTrailing: Edges {
        var edges = self
        edges.useLeadingAndTraling = true
        return edges
    }
}

public enum Edge: Equatable {
    case left, right, top, bottom
    static fileprivate let all = [Edge.left, .right, .top, .bottom]
    
    fileprivate func constraint(view: UIView, with edges: Edges) -> NSLayoutConstraint {
        let layout = view.layout
        var constraint = NSLayoutConstraint.empty
        switch (self, edges.useLeadingAndTraling, edges.isRelativeToMargins) {
        // Left
        case (.left, false, false):
            layout.left = (edges.view.layout.left - edges.insets.left) => constraint
        
        case (.left, false, true):
            layout.leftMargin = (edges.view.layout.leftMargin - edges.insets.left) => constraint
            
        case (.left, true, false):
            layout.leading = (edges.view.layout.leading - edges.insets.left) => constraint
            
        case (.left, true, true):
            layout.leadingMargin = (edges.view.layout.leadingMargin - edges.insets.left) => constraint
            
        // Right
        case (.right, false, false):
            layout.right = (edges.view.layout.right + edges.insets.right) => constraint
            
        case (.right, false, true):
            layout.rightMargin = (edges.view.layout.rightMargin + edges.insets.right) => constraint
            
        case (.right, true, false):
            layout.trailing = (edges.view.layout.trailing + edges.insets.right) => constraint
            
        case (.right, true, true):
            layout.trailingMargin = (edges.view.layout.trailingMargin + edges.insets.right) => constraint
            
        // Top
        case (.top, _, false):
            layout.top = (edges.view.layout.top - edges.insets.top) => constraint
            
        case (.top, _, true):
            layout.top = (edges.view.layout.top - edges.insets.top) => constraint
            
        // Bottom
        case (.bottom, _, false):
            layout.bottom = (edges.view.layout.bottom + edges.insets.bottom) => constraint
            
        case (.bottom, _, true):
            layout.bottom = (edges.view.layout.bottom + edges.insets.bottom) => constraint
        }
        
        return constraint
    }
}

public func - (edges: Edges, excluded: Edge) -> Edges {
    guard let index = edges.edges.index(of: excluded) else { return edges }
    var edges = edges
    edges.edges.remove(at: index)
    return edges
}

public func + (edges: Edges, insets: UIEdgeInsets) -> Edges {
    var edges = edges
    edges.insets.left += insets.left
    edges.insets.right += insets.right
    edges.insets.top += insets.left
    edges.insets.bottom += insets.bottom
    return edges
}

public func - (edges: Edges, insets: UIEdgeInsets) -> Edges {
    return edges + UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right)
}

public func + (edges: Edges, inset: CGFloatConvertible) -> Edges {
    let value = inset.layoutCGFloat
    let insets = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    return edges + insets
}

public func - (edges: Edges, inset: CGFloatConvertible) -> Edges {
    return edges + -inset.layoutCGFloat
}

public func => (edges: Edges, constraints: inout [NSLayoutConstraint]) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(&constraints)
    return edges
}

public func => (edges: Edges, constraints: inout [NSLayoutConstraint]?) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(withOptional: &constraints)
    return edges
}

public func => (edges: Edges, constraints: inout [NSLayoutConstraint]!) -> Edges {
    var edges = edges
    edges.constraintsPointer = MultiTypePointer(withForcedUnwrapped: &constraints)
    return edges
}

public extension Layout {
    public var edges: Edges {
        get {
            return Edges(view: view)
        }
        set {
            let constraints = newValue.edges.map { $0.constraint(view: view, with: newValue) }
            newValue.constraintsPointer?.setPointee(constraints)
        }
    }
}
