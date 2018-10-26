//
//  SizeTests.swift
//  MaketaTests
//
//  Created by Manuel García-Estañ on 13/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
@testable import Maketa

class SizeTests: ConstraintsTestCase {
    
    // MARK: - Basic
    
    func testViewCanSetSizeWithConstant() {
        
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 30)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testViewCanSetSizeWithCGSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testViewCanSetSizeWithOtherSize() {
        // given        
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = view0.mkt.size => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    // MARK: - Relations
    func testLessRelationshipInConstant() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size < 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 30)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testGreaterRelationshipInConstant() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size > 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 30)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testLessRelationWithCGSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size < CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testGreaterRelationWithCGSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size > CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testLessRelationWithFixedSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size < (CGSize(width: 10, height: 20) & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .defaultLow)
    }
    
    func testGreaterRelationWithFixedSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size > (CGSize(width: 10, height: 20) & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .defaultLow)
    }
    
    func testLessRelationWithOtherSize() {
        // given
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size < view0.mkt.size => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testGreaterRelationWithOtherSize() {
        // given
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size > view0.mkt.size => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    // MARK: - Priority
    func testViewCanSetCustomPriorityWithConstant() {
        
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (30 & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 30)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .defaultLow)
    }
    
    func testViewCanSetCustomPriorityWithCGSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .defaultLow)
    }
    
    func testCanSetCustomPriorityWithFixedSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) & .defaultLow & .defaultHigh) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultHigh)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertTrue(constraintHeight.secondItem == nil)
        XCTAssertEqual(constraintHeight.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintHeight.constant, 20)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .defaultHigh)
    }
    
    func testViewCanSetCustomPriorityWithOtherSize() {
        // given
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .defaultLow)
    }
    
    // MARK: - Assignement
    func testSizeConstraintsCanBeAddedWithoutAssignment() {
        
        // given
        let view = UIView()
        
        // when
        view.mkt.size = 30
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
    }
    
    func testSizeConstraintsCanBeAssignedToOptionalConstraints() {
        
        // given
        var constraints: SizeConstraints?
        let view = UIView()
        
        // when
        view.mkt.size = 30 => constraints
        
        // then
        XCTAssertNotNil(constraints)
    }
    
    func testSizeConstraintsCanBeAssignedToForcedUnwrappedConstraints() {
        
        // given
        var constraints: SizeConstraints!
        let view = UIView()
        
        // when
        view.mkt.size = 30 => constraints
        
        // then
        XCTAssertNotNil(constraints)
    }
    
    // MARK: - Operations
    func testOffsetCanBeSubstractedFromConstant() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (30 - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 25)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 20)
    }
    
    func testOffsetCanBeSustractedFromCGSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 10)
    }
    
    func testOffsetCanBeSustractedFromFixedSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        let size = (CGSize(width: 10, height: 20) & .defaultLow)
        view.mkt.size = (size - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 10)
    }
    
    func testOffsetCanBeSubstractedFromOtherSize() {
        // given
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, -5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, -10)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testAddOffsetCommutativeProperty() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (UIOffset(horizontal: 5, vertical: 10) + 30) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 35)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 40)
    }
    
    func testConstantCanBeSubstractedFromConstant() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (30 - 10) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 20)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 20)
    }
    
    func testConstantCanBeSustractedFromCGSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) - 5) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 15)
    }
    
    func testConstantCanBeSustractedFromFixedSize() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        let size = CGSize(width: 10, height: 20) & .defaultLow
        view.mkt.size = (size - 5) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 15)
    }
    
    func testConstantCanBeSubstractedFromOtherSize() {
        // given
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size - 5) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, -5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, -5)
        XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testAddConstantCommutativeProperty() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (10 + CGSize(width: 30, height: 40)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 40)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 50)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testConstantCanBeDivided() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        let size: Size = 30
        view.mkt.size = (size / 2) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 15)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 15)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testCGSizeCanBeDivided() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) / 2) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 10)
        XCTAssertEqual(constraintHeight.multiplier, 1)
    }
    
    func testFixedSizeCanBeDivided() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        let size = CGSize(width: 10, height: 20) & .defaultLow
        view.mkt.size = (size / 2) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 5)
        XCTAssertEqual(constraintWidth.multiplier, 1)

        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 10)
        XCTAssertEqual(constraintHeight.multiplier, 1)

    }
    
    func testOtherViewSizeCanBeDivided() {
        // given
        var constraints = SizeConstraints()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size / 2) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertTrue(constraintWidth.secondItem === view0)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.secondAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 0)
        XCTAssertEqual(constraintWidth.multiplier, 0.5)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertTrue(constraintHeight.secondItem === view0)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.secondAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 0)
        XCTAssertEqual(constraintHeight.multiplier, 0.5)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
    
    func testSizeProductCommutativeProperty() {
        // given
        var constraints = SizeConstraints()
        let view = UIView()
        
        // when
        view.mkt.size = (10 * CGSize(width: 30, height: 40)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        
        let constraintWidth = constraints.width
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 300)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints.height
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 400)
         XCTAssertEqual(constraintHeight.multiplier, 1)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
	
	// MARK: Autolayout not changed on right side
	func testAutolayoutIsNotActivatedOnRightView() {
		// given
		let view = UIView()
		superview.addSubview(view)
		
		let otherView = UIView()
		superview.addSubview(otherView)
		
		XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
		XCTAssertTrue(otherView.translatesAutoresizingMaskIntoConstraints)
		
		// when
		view.mkt.size = otherView.mkt.size
		
		// then
		XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
		XCTAssertTrue(otherView.translatesAutoresizingMaskIntoConstraints)
	}
	
	func testAutolayoutIsNotDeactivatedOnRightView() {
		// given
		let view = UIView()
		superview.addSubview(view)
		
		let otherView = UIView()
		otherView.preparedForAutolayout()
		superview.addSubview(otherView)
		
		XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
		XCTAssertFalse(otherView.translatesAutoresizingMaskIntoConstraints)
		
		// when
		view.mkt.size = otherView.mkt.size
		
		// then
		XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
		XCTAssertFalse(otherView.translatesAutoresizingMaskIntoConstraints)
	}
	
	// MARK: - Super
	func testViewCanSetSizeWithSuperSize() {
		// given
		var constraints = SizeConstraints()
		superview.mkt.size = CGSize(width: 10, height: 20)
		let previousConstraintsCount = superview.constraints.count
		
		let view = UIView()
		superview.addSubview(view)
		
		// when
		view.mkt.size = Super.size => constraints
		
		// then
		XCTAssertEqual(superview.constraints.count, previousConstraintsCount + 2)
		
		let constraintWidth = constraints.width
		XCTAssertTrue(constraintWidth.firstItem === view)
		XCTAssertTrue(constraintWidth.secondItem === superview)
		XCTAssertEqual(constraintWidth.firstAttribute, .width)
		XCTAssertEqual(constraintWidth.secondAttribute, .width)
		XCTAssertEqual(constraintWidth.constant, 0)
		XCTAssertEqual(constraintWidth.multiplier, 1)
		XCTAssertEqual(constraintWidth.relation, .equal)
		XCTAssertEqual(constraintWidth.priority, .required)
		
		let constraintHeight = constraints.height
		XCTAssertTrue(constraintHeight.firstItem === view)
		XCTAssertTrue(constraintHeight.secondItem === superview)
		XCTAssertEqual(constraintHeight.firstAttribute, .height)
		XCTAssertEqual(constraintHeight.secondAttribute, .height)
		XCTAssertEqual(constraintHeight.constant, 0)
		XCTAssertEqual(constraintHeight.multiplier, 1)
		XCTAssertEqual(constraintHeight.relation, .equal)
		XCTAssertEqual(constraintHeight.priority, .required)
	}
}
