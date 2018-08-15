//
//  Edges.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit

public struct Edges {
    fileprivate enum Kind {
        case edges, margins
    }
    fileprivate let view: UIView
    fileprivate let kind: Kind
    
    fileprivate var edges: [Edge]
    fileprivate var insets = UIEdgeInsets.zero
    fileprivate var constraintsPointer: MultiTypePointer<[NSLayoutConstraint]>?
    
    fileprivate init(view: UIView, kind: Kind, edges: [Edge]) {
        self.view = view
        self.kind = kind
        self.edges = edges
    }
}

public enum Edge: Equatable {
    case left, right, leading, trailing, top, bottom
    static fileprivate let all = [Edge.left, .right, .top, .bottom]
    static fileprivate let allRelativeToLayoutDirection = [Edge.leading, .trailing, .top, .bottom]
    
    fileprivate func constraint(view: UIView, with edges: Edges) -> NSLayoutConstraint {
        let layout = view.mkt
        var constraint = NSLayoutConstraint.empty
        switch (self, edges.kind) {
        // Left
        case (.left, .edges):
            layout.left = (edges.view.mkt.left - edges.insets.left) => constraint
        
        case (.left, .margins):
            layout.leftMargin = (edges.view.mkt.leftMargin - edges.insets.left) => constraint
            
        // Right
        case (.right, .edges):
            layout.right = (edges.view.mkt.right + edges.insets.right) => constraint
            
        case (.right, .margins):
            layout.rightMargin = (edges.view.mkt.rightMargin + edges.insets.right) => constraint
            
        // Leading
        case (.leading, .edges):
            layout.leading = (edges.view.mkt.leading - edges.insets.left) => constraint
            
        case (.leading, .margins):
            layout.leadingMargin = (edges.view.mkt.leadingMargin - edges.insets.left) => constraint
            
        // Trailing
        case (.trailing, .edges):
            layout.trailing = (edges.view.mkt.trailing + edges.insets.right) => constraint
            
        case (.trailing, .margins):
            layout.trailingMargin = (edges.view.mkt.trailingMargin + edges.insets.right) => constraint
            
        // Top
        case (.top, .edges):
            layout.top = (edges.view.mkt.top - edges.insets.top) => constraint
            
        case (.top, .margins):
            layout.topMargin = (edges.view.mkt.topMargin - edges.insets.top) => constraint
            
        // Bottom
        case (.bottom, .edges):
            layout.bottom = (edges.view.mkt.bottom + edges.insets.bottom) => constraint
            
        case (.bottom, .margins):
            layout.bottomMargin = (edges.view.mkt.bottomMargin + edges.insets.bottom) => constraint
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
    edges.insets.top += insets.top
    edges.insets.bottom += insets.bottom
    return edges
}

public func - (edges: Edges, insets: UIEdgeInsets) -> Edges {
    return edges + UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right)
}

public func + (edges: Edges, inset: LayoutCGFloatConvertible) -> Edges {
    let value = inset.layoutCGFloat
    let insets = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    return edges + insets
}

public func - (edges: Edges, inset: LayoutCGFloatConvertible) -> Edges {
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

public extension Maketa {
    public var edges: Edges {
        get {
            return Edges(view: view, kind: .edges, edges: Edge.all)
        }
        set {
            setEdges(newValue)
        }
    }
    
    public var margins: Edges {
        return Edges(view: view, kind: .margins, edges: Edge.all)
    }
    
    public var layoutDirectionEdges: Edges {
        return Edges(view: view, kind: .edges, edges: Edge.allRelativeToLayoutDirection)
    }
    
    public var layoutDirectionMargins: Edges {
        return Edges(view: view, kind: .margins, edges: Edge.allRelativeToLayoutDirection)
    }
    
    private func setEdges(_ newValue: Edges) {
        let constraints = newValue.edges.map { $0.constraint(view: view, with: newValue) }
        newValue.constraintsPointer?.setPointee(constraints)
    }
}
