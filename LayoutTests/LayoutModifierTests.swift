//
//  LayoutModifierTesta.swift
//  LayoutTests
//
//  Created by Manuel García-Estañ on 15/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

import XCTest
@testable import Layout

class LayoutModifierTests: ConstraintsTestCase {
    
    var view = UIView()
    
    override func setUp() {
        super.setUp()
        superview.addSubview(view)
    }
    
    override func tearDown() {
        superview.removeConstraints(superview.constraints)
        view.removeConstraints(view.constraints)
        super.tearDown()
    }
    
    func testLeftAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.left = superview.layout.left => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .left)
        XCTAssertEqual(constraint.secondAttribute, .left)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testRightAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.right = superview.layout.right => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .right)
        XCTAssertEqual(constraint.secondAttribute, .right)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testTopAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.top = superview.layout.top => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .top)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testBottomAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.bottom = superview.layout.bottom => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .bottom)
        XCTAssertEqual(constraint.secondAttribute, .bottom)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testLeadingAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.leading = superview.layout.leading => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testTrailingAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.trailing = superview.layout.trailing => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testWidthAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.width = superview.layout.width => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testHeightAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.height = superview.layout.height => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testCenterXAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.centerX = superview.layout.centerX => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .centerX)
        XCTAssertEqual(constraint.secondAttribute, .centerX)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testCenterYAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.centerY = superview.layout.centerY => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .centerY)
        XCTAssertEqual(constraint.secondAttribute, .centerY)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testLastBaselineAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.lastBaseline = superview.layout.lastBaseline => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .lastBaseline)
        XCTAssertEqual(constraint.secondAttribute, .lastBaseline)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testFirsBaselineAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.firstBaseline = superview.layout.firstBaseline => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .firstBaseline)
        XCTAssertEqual(constraint.secondAttribute, .firstBaseline)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testLeftMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.leftMargin = superview.layout.leftMargin => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .leftMargin)
        XCTAssertEqual(constraint.secondAttribute, .leftMargin)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testRightMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.rightMargin = superview.layout.rightMargin => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .rightMargin)
        XCTAssertEqual(constraint.secondAttribute, .rightMargin)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testTopMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.topMargin = superview.layout.topMargin => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .topMargin)
        XCTAssertEqual(constraint.secondAttribute, .topMargin)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testBottomMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.bottomMargin = superview.layout.bottomMargin => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .bottomMargin)
        XCTAssertEqual(constraint.secondAttribute, .bottomMargin)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testLeadingMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.leadingMargin = superview.layout.leadingMargin => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .leadingMargin)
        XCTAssertEqual(constraint.secondAttribute, .leadingMargin)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testTrailingMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.trailingMargin = superview.layout.trailingMargin => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .trailingMargin)
        XCTAssertEqual(constraint.secondAttribute, .trailingMargin)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testCenterXWithinMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.centerXWithinMargins = superview.layout.centerXWithinMargins => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraint.secondAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testCenterYWithinMarginAttribute() {
        
        // given
        var constraint = NSLayoutConstraint.empty
        
        // when
        view.layout.centerYWithinMargins = superview.layout.centerYWithinMargins => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraint.secondAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    // MARK: - Aspect ratio
    
    func testSetAspectRatio() {
        // when
        view.layout.aspectRatio = 2
        
        // then
        let constraint = view.constraints.first!
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testGetAspectRatio() {
        // when
        view.layout.width = 100
        view.layout.aspectRatio = 2
        view.layoutIfNeeded()
        
        // then
        XCTAssertEqual(view.layout.aspectRatio, 2)
    }
}
