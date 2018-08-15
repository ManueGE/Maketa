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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = view0.mkt.size => constraints
        
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
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size < 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size > 30 => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size < CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size > CGSize(width: 10, height: 20) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size < (CGSize(width: 10, height: 20) & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size > (CGSize(width: 10, height: 20) & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size < view0.mkt.size => constraints
        
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
        XCTAssertEqual(constraintWidth.relation, .lessThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size > view0.mkt.size => constraints
        
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
        XCTAssertEqual(constraintWidth.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = (30 & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 30)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = (CGSize(width: 10, height: 20) & .defaultLow & .defaultHigh) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertTrue(constraintWidth.secondItem == nil)
        XCTAssertEqual(constraintWidth.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraintWidth.constant, 10)
        XCTAssertEqual(constraintWidth.multiplier, 1)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultHigh)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view0 = UIView()
        superview.addSubview(view0)
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size & .defaultLow) => constraints
        
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
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .defaultLow)
        
        let constraintHeight = constraints[1]
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
    
    func testSizeConstraintsCanBeAssignedToOptionalArray() {
        
        // given
        var constraints: [NSLayoutConstraint]?
        let view = UIView()
        
        // when
        view.mkt.size = 30 => constraints
        
        // then
        XCTAssertEqual(constraints!.count, 2)
    }
    
    func testSizeConstraintsCanBeAssignedToForcedUnwrappedArray() {
        
        // given
        var constraints: [NSLayoutConstraint]!
        let view = UIView()
        
        // when
        view.mkt.size = 30 => constraints
        
        // then
        XCTAssertEqual(constraints.count, 2)
    }
    
    // MARK: - Operations
    func testOffsetCanBeSubstractedFromConstant() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = (30 - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
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
        view.mkt.size = (CGSize(width: 10, height: 20) - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
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
    
    func testOffsetCanBeSustractedFromFixedSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        let size = (CGSize(width: 10, height: 20) & .defaultLow)
        view.mkt.size = (size - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
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
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size - UIOffset(horizontal: 5, vertical: 10)) => constraints
        
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
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = (UIOffset(horizontal: 5, vertical: 10) + 30) => constraints
        
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
        view.mkt.size = (30 - 10) => constraints
        
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
        view.mkt.size = (CGSize(width: 10, height: 20) - 5) => constraints
        
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
    
    func testConstantCanBeSustractedFromFixedSize() {
        // given
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        let size = CGSize(width: 10, height: 20) & .defaultLow
        view.mkt.size = (size - 5) => constraints
        
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
        view0.mkt.size = CGSize(width: 10, height: 20)
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.size = (view0.mkt.size - 5) => constraints
        
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
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
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
        var constraints = [NSLayoutConstraint]()
        let view = UIView()
        
        // when
        view.mkt.size = (10 + CGSize(width: 30, height: 40)) => constraints
        
        // then
        XCTAssertEqual(view.constraints.count, 2)
        XCTAssertEqual(constraints.count, 2)
        
        let constraintWidth = constraints[0]
        XCTAssertTrue(constraintWidth.firstItem === view)
        XCTAssertEqual(constraintWidth.firstAttribute, .width)
        XCTAssertEqual(constraintWidth.constant, 40)
        XCTAssertEqual(constraintWidth.relation, .equal)
        XCTAssertEqual(constraintWidth.priority, .required)
        
        let constraintHeight = constraints[1]
        XCTAssertTrue(constraintHeight.firstItem === view)
        XCTAssertEqual(constraintHeight.firstAttribute, .height)
        XCTAssertEqual(constraintHeight.constant, 50)
        XCTAssertEqual(constraintHeight.relation, .equal)
        XCTAssertEqual(constraintHeight.priority, .required)
    }
}