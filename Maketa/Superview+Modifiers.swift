//
//  Superview+Modifiers.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 26/10/2018.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

extension Superview {
	/// The left side of the object’s alignment rectangle.
	public static var left: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .left)
	}
	
	/// The right side of the object’s alignment rectangle.
	public static var right: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .right)
	}
	
	/// The top of the object’s alignment rectangle.
	public static var top: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .top)
	}
	
	/// The bottom of the object’s alignment rectangle.
	public static var bottom: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .bottom)
	}
	
	/// The leading edge of the object’s alignment rectangle.
	public static var leading: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .leading)
	}
	
	/// The trailing edge of the object’s alignment rectangle.
	public static var trailing: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .trailing)
	}
	
	/// The width of the object’s alignment rectangle.
	public static var width: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .width)
	}
	
	/// The height of the object’s alignment rectangle.
	public static var height: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .height)
	}
	
	/// The center along the x-axis of the object’s alignment rectangle.
	public static var centerX: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .centerX)
	}
	
	/// The center along the y-axis of the object’s alignment rectangle.
	public static var centerY: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .centerY)
	}
	
	/// The object’s baseline. For objects with more than one line of text, this is the baseline for the bottommost line of text.
	public static var lastBaseline: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .lastBaseline)
	}
	
	/// The object’s baseline. For objects with more than one line of text, this is the baseline for the topmost line of text.
	public static var firstBaseline: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .firstBaseline)
	}
	
	/// The object’s left margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
	public static var leftMargin: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .leftMargin)
	}
	
	/// The object’s right margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
	public static var rightMargin: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .rightMargin)
	}
	
	/// The object’s top margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
	public static var topMargin: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .topMargin)
	}
	
	/// The object’s bottom margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
	public static var bottomMargin: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .bottomMargin)
	}
	
	/// The object’s leading margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
	public static var leadingMargin: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .leadingMargin)
	}
	
	/// The object’s trailing margin. For `UIView` objects, the margins are defined by their `layoutMargins` `property`.
	public static var trailingMargin: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .trailingMargin)
	}
	
	/// The center along the x-axis between the object’s left and right margin. For `UIView` objects, the margins are defined by their `layoutMargins`     `property`.
	public static var centerXWithinMargins: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .centerXWithinMargins)
	}
	
	/// The center along the y-axis between the object’s left and right margin. For `UIView` objects, the margins are defined by their `layoutMargins`     `property`.
	public static var centerYWithinMargins: AttributeModifier {
		return LayoutAttribute(view: .superview, attribute: .centerYWithinMargins)
	}
}
