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
    
    private static var key: UInt8 = 0
    
    /// Returns the layout object associated to the view
    public private(set) var mkt: Maketa {
        get {
            let maketa: Maketa
            if let mkt = objc_getAssociatedObject(self, &UIView.key) as? Maketa {
                maketa = mkt
            } else {
                maketa = Maketa(view: self)
                self.mkt = maketa
            }
            return maketa
        }
        set {
            objc_setAssociatedObject(self, &UIView.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
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
