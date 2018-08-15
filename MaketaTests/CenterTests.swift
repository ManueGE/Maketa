//
//  CenterTests.swift
//  MaketaTests
//
//  Created by Manuel García-Estañ on 14/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
import Maketa

class CenterTests: ConstraintsTestCase {
    
    // MARK: - Basic
    func testCenterCanBeSet() {
        // given
        var constraints = [NSLayoutConstraint]()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === superview)
        XCTAssertEqual(constraintWidth.firstAttribute, .centerX)
        XCTAssertEqual(constraintWidth.secondAttribute, .centerX)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === superview)
        XCTAssertEqual(constraintHeight.firstAttribute, .centerY)
        XCTAssertEqual(constraintHeight.secondAttribute, .centerY)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    // MARK: - Assignement
    func testCenterConstraintsCanBeAddedWithoutAssignment() {
        
        // given
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
    }
    
    func testCenterConstraintsCanBeAssignedToOptionalArray() {
        
        // given
        var constraints: [NSLayoutConstraint]?
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints!.count, 2)
    }
    
    func testCenterConstraintsCanBeAssignedToForcedUnwrappedArray() {
        
        // given
        var constraints: [NSLayoutConstraint]!
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints.count, 2)
    }
    
    // MARK: - Operations
    func testOffsetCanBeSubstractedFromCenter() {
        // given
        var constraints = [NSLayoutConstraint]()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (superview.mkt.center - UIOffset(horizontal: 10, vertical: 5)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === superview)
        XCTAssertEqual(constraintWidth.firstAttribute, .centerX)
        XCTAssertEqual(constraintWidth.secondAttribute, .centerX)
        XCTAssertEqual(constraintWidth.constant, -10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === superview)
        XCTAssertEqual(constraintHeight.firstAttribute, .centerY)
        XCTAssertEqual(constraintHeight.secondAttribute, .centerY)
        XCTAssertEqual(constraintHeight.constant, -5)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testConstantCanBeSubstractedFromCenter() {
        // given
        var constraints = [NSLayoutConstraint]()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (superview.mkt.center - 5) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === superview)
        XCTAssertEqual(constraintWidth.firstAttribute, .centerX)
        XCTAssertEqual(constraintWidth.secondAttribute, .centerX)
        XCTAssertEqual(constraintWidth.constant, -5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === superview)
        XCTAssertEqual(constraintHeight.firstAttribute, .centerY)
        XCTAssertEqual(constraintHeight.secondAttribute, .centerY)
        XCTAssertEqual(constraintHeight.constant, -5)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testAddOffsetCommutateProperty() {
        // given
        var constraints = [NSLayoutConstraint]()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (UIOffset(horizontal: 10, vertical: 5) + superview.mkt.center) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === superview)
        XCTAssertEqual(constraintWidth.firstAttribute, .centerX)
        XCTAssertEqual(constraintWidth.secondAttribute, .centerX)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === superview)
        XCTAssertEqual(constraintHeight.firstAttribute, .centerY)
        XCTAssertEqual(constraintHeight.secondAttribute, .centerY)
        XCTAssertEqual(constraintHeight.constant, 5)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testAddConstantCommutateProperty() {
        // given
        var constraints = [NSLayoutConstraint]()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (5.5 + superview.mkt.center) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === superview)
        XCTAssertEqual(constraintWidth.firstAttribute, .centerX)
        XCTAssertEqual(constraintWidth.secondAttribute, .centerX)
        XCTAssertEqual(constraintWidth.constant, 5.5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === superview)
        XCTAssertEqual(constraintHeight.firstAttribute, .centerY)
        XCTAssertEqual(constraintHeight.secondAttribute, .centerY)
        XCTAssertEqual(constraintHeight.constant, 5.5)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
}
