//
//  UIView+Layout.swift
//  Layout
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
            if let layout = objc_getAssociatedObject(self, &UIView.layoutKey) as? Layout {
                return layout
            } else {
                let layout = Layout(view: self)
                self.layout = layout
                return layout
            }
        }
        set {
            objc_setAssociatedObject(self, &UIView.layoutKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
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
