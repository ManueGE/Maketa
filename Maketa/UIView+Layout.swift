//
//  UIView+Layout.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation
import ObjectiveC

// MARK: UIView extension
/**
 An extension to have access to the layout object associated to the view
 */
public extension UIView {
    
    private static var layoutKey: UInt8 = 0
    
    /// Returns the layout object associated to the view
    public private(set) var layout: Layout {
        get {
            let layout: Layout
            if let lyt = objc_getAssociatedObject(self, &UIView.layoutKey) as? Layout {
                layout = lyt
            } else {
                layout = Layout(view: self)
                self.layout = layout
            }
            return layout
        }
        set {
            objc_setAssociatedObject(self, &UIView.layoutKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Returns the layout object associated to the receiver's superview. It throws a fatal error if view has not a superview
    public var superLayout: Layout {
        return layout.superLayout
    }
    
    /// Adjust the needed properties to be able to use the view in autolayout and returns the view itself.
    @discardableResult
    public func preparedForAutolayout() -> Self {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}
