//
//  View.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 26/10/2018.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

/// Abstraction to provide a view.
enum View {
	/// the view is assigned directly
	case view(UIView)
	
	/// the superview of the receiver will be used
	case superview
	
	/// returns the view that must be used
	func target(for view: UIView) -> UIView {
		switch self {
		case let .view(view):
			return view
			
		case .superview:
			guard let superview = view.superview else {
				fatalError("Can't use `Superview` on \(view) because it has not a superview")
			}
			return superview
		}
	}
}
