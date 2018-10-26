//
//  AttributeModifierTests.swift
//  MaketaTests
//
//  Created by Manuel García-Estañ on 15/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

import XCTest
@testable import Maketa

class Super_AttributeModifierTests: ConstraintsTestCase {
    
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
        view.mkt.left = Superview.left => constraint
        
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
        view.mkt.right = Superview.right => constraint
        
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
        view.mkt.top = Superview.top => constraint
        
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
        view.mkt.bottom = Superview.bottom => constraint
        
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
        view.mkt.leading = Superview.leading => constraint
        
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
        view.mkt.trailing = Superview.trailing => constraint
        
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
        view.mkt.width = Superview.width => constraint
        
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
        view.mkt.height = Superview.height => constraint
        
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
        view.mkt.centerX = Superview.centerX => constraint
        
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
        view.mkt.centerY = Superview.centerY => constraint
        
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
        view.mkt.lastBaseline = Superview.lastBaseline => constraint
        
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
        view.mkt.firstBaseline = Superview.firstBaseline => constraint
        
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
        view.mkt.leftMargin = Superview.leftMargin => constraint
        
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
        view.mkt.rightMargin = Superview.rightMargin => constraint
        
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
        view.mkt.topMargin = Superview.topMargin => constraint
        
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
        view.mkt.bottomMargin = Superview.bottomMargin => constraint
        
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
        view.mkt.leadingMargin = Superview.leadingMargin => constraint
        
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
        view.mkt.trailingMargin = Superview.trailingMargin => constraint
        
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
        view.mkt.centerXWithinMargins = Superview.centerXWithinMargins => constraint
        
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
        view.mkt.centerYWithinMargins = Superview.centerYWithinMargins => constraint
        
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
}
