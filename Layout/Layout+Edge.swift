//
//  Layout+Edge.swift
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
    
    fileprivate func constraint(view: UIView, with edges: Edges) {
        let layout = view.layout
        switch (self, edges.useLeadingAndTraling, edges.isRelativeToMargins) {
        // Left
        case (.left, false, false):
            layout.left = edges.view.layout.left + edges.insets.left
        
        case (.left, false, true):
            layout.leftMargin = edges.view.layout.leftMargin + edges.insets.left
            
        case (.left, true, false):
            layout.leading = edges.view.layout.leading + edges.insets.left
            
        case (.left, true, true):
            layout.leadingMargin = edges.view.layout.leadingMargin + edges.insets.left
            
        // Right
        case (.right, false, false):
            layout.right = edges.view.layout.right - edges.insets.right
            
        case (.right, false, true):
            layout.rightMargin = edges.view.layout.rightMargin - edges.insets.right
            
        case (.right, true, false):
            layout.trailing = edges.view.layout.trailing - edges.insets.right
            
        case (.right, true, true):
            layout.trailingMargin = edges.view.layout.trailingMargin - edges.insets.right
            
        // Top
        case (.top, _, false):
            layout.top = edges.view.layout.top + edges.insets.top
            
        case (.top, _, true):
            layout.top = edges.view.layout.top + edges.insets.top
            
        // Bottom
        case (.bottom, _, false):
            layout.bottom = edges.view.layout.bottom - edges.insets.bottom
            
        case (.bottom, _, true):
            layout.bottom = edges.view.layout.bottom - edges.insets.bottom
        }
    }
}

public func - (edges: Edges, excluded: Edge) -> Edges {
    guard let index = edges.edges.index(of: excluded) else { return edges }
    var edges = edges
    edges.edges.remove(at: index)
    return edges
}

public func - (edges: Edges, insets: UIEdgeInsets) -> Edges {
    var edges = edges
    edges.insets.left += insets.left
    edges.insets.right += insets.right
    edges.insets.top += insets.left
    edges.insets.bottom += insets.bottom
    return edges
}

public func - (edges: Edges, inset: CGFloatConvertible) -> Edges {
    let value = inset.cgFloat
    let insets = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    return edges - insets
}


public extension Layout {
    public var edges: Edges {
        get { return Edges(view: view) }
        set { newValue.edges.forEach { $0.constraint(view: view, with: newValue) } }
    }
}
