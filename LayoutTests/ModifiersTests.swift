//
//  LayoutModifierTests.swift
//  LayoutTests
//
//  Created by Manuel García-Estañ on 13/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
@testable import Layout

class LayoutModifierTests: ConstraintsTestCase {

    // MARK: - Assignements
    func testConstraintCanBeSetWithoutAssign() {
        // given
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left = superview.layout.left
        
        // then
        XCTAssertEqual(superview.constraints.count, 1)
    }

    func testConstraintCanBeAssignedToOptionalConstraint() {
        // given
        var constraint: NSLayoutConstraint?
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left = superview.layout.left => constraint
        
        // then
        XCTAssertNotNil(constraint)
    }
    
    func testConstraintCanBeAssignedToForcedUnwrappedConstraint() {
        // given
        var constraint: NSLayoutConstraint!
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left = superview.layout.left => constraint
        
        // then
        XCTAssertNotNil(constraint)
    }
    
    // MARK: - Relationships
    func testEqualRelationship() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left = superview.layout.left => constraint
        
        // then
        XCTAssertEqual(constraint.relation, .equal)
    }
    
    func testLessThanRelationship() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left < superview.layout.left => constraint
        
        // then
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
    }
    
    func testGreaterThanRelationship() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left > superview.layout.left => constraint
        
        // then
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
    }
    
    // MARK: - LayoutAttribute Operations
    func testAddConstantToAttribute() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left = (superview.layout.right - 10) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .left)
        XCTAssertEqual(constraint.secondAttribute, .right)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, -10)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testAddConstantToAttributeCommutativeProperty() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.left = (10 + superview.layout.right) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .left)
        XCTAssertEqual(constraint.secondAttribute, .right)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testCanMultiplyAttributeByConstraint() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.height = (superview.layout.width / 2) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.multiplier, 0.5)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testMultiplyAttributeCommutativeProperty() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.height = (0.5 * superview.layout.width) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.multiplier, 0.5)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testSetPriorityToAttribute() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.height = (superview.layout.height & .defaultLow) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertTrue(constraint.secondItem === superview)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .defaultLow)
    }
    
    // MARK: - FloatConvertible Operations
    func testAddConstantToFloatConvertible() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        let value: LayoutModifier = -10
        view.layout.height = (value - 10) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, -20)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testMultiplyFloatConvertibleByConstant() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        let value: LayoutModifier = 10
        view.layout.height = (value * 10) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 100)
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func testCanSetPriorityToFloatConvertible() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        let value: LayoutModifier = 10
        view.layout.height = (value & .defaultLow) => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.priority, .defaultLow)
    }
    
    func testCanSetRelationshipToFloatConvertible() {
        // given
        var constraint = NSLayoutConstraint.empty
        let view = UIView()
        superview.addSubview(view)
        
        // when
        let value: LayoutModifier = Float(10)
        view.layout.height < value => constraint
        
        // then
        XCTAssertTrue(constraint.firstItem === view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
    }
}
