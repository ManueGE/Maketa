//
//  SizeTests.swift
//  LayoutTests
//
//  Created by Manuel García-Estañ on 13/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
@testable import Layout

class SizeTests: ConstraintsTestCase {
    
    // MARK: - Basic
    
    func testViewCanSetSizeWithConstant() {
        
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 30)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 30)
    }
    
    func testViewCanSetSizeWithCGSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 10)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 20)
    }
    
    func testViewCanSetSizeWithOtherSize() {
        // given        
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.layout.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.size = view0.layout.size => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    // MARK: - Assignement
    func testSizeConstraintsCanBeAddedWithoutAssignment() {
        
        // given
        let view = UIView()
        
        // when
        view.layout.size = 30
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
    }
    
    func testSizeConstraintsCanBeAssignedToOptionalArray() {
        
        // given
        var constraints: [NSLayoutConstraint]?
        let view = UIView()
        
        // when
        view.layout.size = 30 => constraints
        
        // then
        XCTAssertEqual(constraints!.count, 2)
    }
    
    func testSizeConstraintsCanBeAssignedToForcedUnwrappedArray() {
        
        // given
        var constraints: [NSLayoutConstraint]!
        let view = UIView()
        
        // when
        view.layout.size = 30 => constraints
        
        // then
        XCTAssertEqual(constraints.count, 2)
    }
    
    // MARK: - Operations
    func testOffsetCanBeSubstractedFromConstant() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = (30 - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 25)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 20)
    }
    
    func testOffsetCanBeSustractedFromCGSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = (CGSize(width: 10, height: 20) - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 10)
    }
    
    func testOffsetCanBeSubstractedFromOtherSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.layout.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.size = (view0.layout.size - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, -5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, -10)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testAddOffsetCommutativeProperty() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = (UIOffset(horizontal: 5, vertical: 10) + 30) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 35)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 40)
    }
    
    func testConstantCanBeSubstractedFromConstant() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = (30 - 10) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 20)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 20)
    }
    
    func testConstantCanBeSustractedFromCGSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = (CGSize(width: 10, height: 20) - 5) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 15)
    }
    
    func testConstantCanBeSubstractedFromOtherSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.layout.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.size = (view0.layout.size - 5) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, -5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, -5)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testAddConstantCommutativeProperty() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.layout.size = (10 + CGSize(width: 30, height: 40)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 40)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 50)
    }
}
