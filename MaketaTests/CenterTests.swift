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
        var constraints = CenterConstraints()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintX = constraints.x
        XCTAssertTrue(constraintX.firstItem === view)
        XCTAssertTrue(constraintX.secondItem === superview)
        XCTAssertEqual(constraintX.firstAttribute, .centerX)
        XCTAssertEqual(constraintX.secondAttribute, .centerX)
        XCTAssertEqual(constraintX.constant, 0)
        XCTAssertEqual(constraintX.multiplier, 1)
        
        let constraintY = constraints.y
        XCTAssertTrue(constraintY.firstItem === view)
        XCTAssertTrue(constraintY.secondItem === superview)
        XCTAssertEqual(constraintY.firstAttribute, .centerY)
        XCTAssertEqual(constraintY.secondAttribute, .centerY)
        XCTAssertEqual(constraintY.constant, 0)
        XCTAssertEqual(constraintY.multiplier, 1)
    }
    
    func testCenterWithinMarginCanBeSet() {
        // given
        var constraints = CenterConstraints()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.centerWithinMargins => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintX = constraints.x
        XCTAssertTrue(constraintX.firstItem === view)
        XCTAssertTrue(constraintX.secondItem === superview)
        XCTAssertEqual(constraintX.firstAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraintX.secondAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraintX.constant, 0)
        XCTAssertEqual(constraintX.multiplier, 1)
        
        let constraintY = constraints.y
        XCTAssertTrue(constraintY.firstItem === view)
        XCTAssertTrue(constraintY.secondItem === superview)
        XCTAssertEqual(constraintY.firstAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraintY.secondAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraintY.constant, 0)
        XCTAssertEqual(constraintY.multiplier, 1)
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
        var constraints: CenterConstraints?
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints!.array.count, 2)
    }
    
    func testCenterConstraintsCanBeAssignedToForcedUnwrappedArray() {
        
        // given
        var constraints: CenterConstraints!
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints.array.count, 2)
    }
    
    // MARK: - Relations
    func testEqualRelationship() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints.x.firstAttribute, .centerX)
        XCTAssertEqual(constraints.x.secondAttribute, .centerX)
        XCTAssertEqual(constraints.x.relation, .equal)
        
        XCTAssertEqual(constraints.y.firstAttribute, .centerY)
        XCTAssertEqual(constraints.y.secondAttribute, .centerY)
        XCTAssertEqual(constraints.y.relation, .equal)
    }
    
    func testEqualRelationshipWithinMargins() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = superview.mkt.centerWithinMargins => constraints
        
        // then
        XCTAssertEqual(constraints.x.firstAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraints.x.secondAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraints.x.relation, .equal)
        
        XCTAssertEqual(constraints.y.firstAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraints.y.secondAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraints.y.relation, .equal)
    }
    
    func testLessThanRelationship() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center < superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints.x.firstAttribute, .centerX)
        XCTAssertEqual(constraints.x.secondAttribute, .centerX)
        XCTAssertEqual(constraints.x.relation, .lessThanOrEqual)
        
        XCTAssertEqual(constraints.y.firstAttribute, .centerY)
        XCTAssertEqual(constraints.y.secondAttribute, .centerY)
        XCTAssertEqual(constraints.y.relation, .lessThanOrEqual)
    }
    
    func testLessThanRelationshipWithinMargins() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center < superview.mkt.centerWithinMargins => constraints
        
        // then
        XCTAssertEqual(constraints.array.count, 2)
        
        XCTAssertEqual(constraints.x.firstAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraints.x.secondAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraints.x.relation, .lessThanOrEqual)
        
        XCTAssertEqual(constraints.y.firstAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraints.y.secondAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraints.y.relation, .lessThanOrEqual)
    }
    
    func testGreaterThanRelationship() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center > superview.mkt.center => constraints
        
        // then
        XCTAssertEqual(constraints.x.firstAttribute, .centerX)
        XCTAssertEqual(constraints.x.secondAttribute, .centerX)
        XCTAssertEqual(constraints.x.relation, .greaterThanOrEqual)
        
        XCTAssertEqual(constraints.y.firstAttribute, .centerY)
        XCTAssertEqual(constraints.y.secondAttribute, .centerY)
        XCTAssertEqual(constraints.y.relation, .greaterThanOrEqual)
    }
    
    func testGreaterThanRelationshipWithinMargins() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center > superview.mkt.centerWithinMargins => constraints
        
        // then
        XCTAssertEqual(constraints.x.firstAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraints.x.secondAttribute, .centerXWithinMargins)
        XCTAssertEqual(constraints.x.relation, .greaterThanOrEqual)
        
        XCTAssertEqual(constraints.y.firstAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraints.y.secondAttribute, .centerYWithinMargins)
        XCTAssertEqual(constraints.y.relation, .greaterThanOrEqual)
    }
    
    // MARK: - Priority
    func testCustomPriority() {
        // given
        var constraints = CenterConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (superview.mkt.center & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(constraints.array.count, 2)
        XCTAssertEqual(constraints.x.priority, .defaultLow)
        XCTAssertEqual(constraints.y.priority, .defaultLow)
    }
    
    // MARK: - Operations
    func testOffsetCanBeSubstractedFromCenter() {
        // given
        var constraints = CenterConstraints()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (superview.mkt.center - UIOffset(horizontal: 10, vertical: 5)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.array.count, 2)
        
        let constraintX = constraints.x
        XCTAssertTrue(constraintX.firstItem === view)
        XCTAssertTrue(constraintX.secondItem === superview)
        XCTAssertEqual(constraintX.firstAttribute, .centerX)
        XCTAssertEqual(constraintX.secondAttribute, .centerX)
        XCTAssertEqual(constraintX.constant, -10)
        XCTAssertEqual(constraintX.multiplier, 1)
        
        let constraintY = constraints.y
        XCTAssertTrue(constraintY.firstItem === view)
        XCTAssertTrue(constraintY.secondItem === superview)
        XCTAssertEqual(constraintY.firstAttribute, .centerY)
        XCTAssertEqual(constraintY.secondAttribute, .centerY)
        XCTAssertEqual(constraintY.constant, -5)
        XCTAssertEqual(constraintY.multiplier, 1)
    }
    
    func testConstantCanBeSubstractedFromCenter() {
        // given
        var constraints = CenterConstraints()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (superview.mkt.center - 5) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        
        let constraintX = constraints.x
        XCTAssertTrue(constraintX.firstItem === view)
        XCTAssertTrue(constraintX.secondItem === superview)
        XCTAssertEqual(constraintX.firstAttribute, .centerX)
        XCTAssertEqual(constraintX.secondAttribute, .centerX)
        XCTAssertEqual(constraintX.constant, -5)
        XCTAssertEqual(constraintX.multiplier, 1)
        
        let constraintY = constraints.y
        XCTAssertTrue(constraintY.firstItem === view)
        XCTAssertTrue(constraintY.secondItem === superview)
        XCTAssertEqual(constraintY.firstAttribute, .centerY)
        XCTAssertEqual(constraintY.secondAttribute, .centerY)
        XCTAssertEqual(constraintY.constant, -5)
        XCTAssertEqual(constraintY.multiplier, 1)
    }
    
    func testAddOffsetCommutateProperty() {
        // given
        var constraints = CenterConstraints()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (UIOffset(horizontal: 10, vertical: 5) + superview.mkt.center) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.array.count, 2)
        
        let constraintX = constraints.x
        XCTAssertTrue(constraintX.firstItem === view)
        XCTAssertTrue(constraintX.secondItem === superview)
        XCTAssertEqual(constraintX.firstAttribute, .centerX)
        XCTAssertEqual(constraintX.secondAttribute, .centerX)
        XCTAssertEqual(constraintX.constant, 10)
        XCTAssertEqual(constraintX.multiplier, 1)
        
        let constraintY = constraints.y
        XCTAssertTrue(constraintY.firstItem === view)
        XCTAssertTrue(constraintY.secondItem === superview)
        XCTAssertEqual(constraintY.firstAttribute, .centerY)
        XCTAssertEqual(constraintY.secondAttribute, .centerY)
        XCTAssertEqual(constraintY.constant, 5)
        XCTAssertEqual(constraintY.multiplier, 1)
    }
    
    func testAddConstantCommutateProperty() {
        // given
        var constraints = CenterConstraints()
        
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.center = (5.5 + superview.mkt.center) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 2)
        XCTAssertEqual(constraints.array.count, 2)
        
        let constraintX = constraints.x
        XCTAssertTrue(constraintX.firstItem === view)
        XCTAssertTrue(constraintX.secondItem === superview)
        XCTAssertEqual(constraintX.firstAttribute, .centerX)
        XCTAssertEqual(constraintX.secondAttribute, .centerX)
        XCTAssertEqual(constraintX.constant, 5.5)
        XCTAssertEqual(constraintX.multiplier, 1)
        
        let constraintY = constraints.y
        XCTAssertTrue(constraintY.firstItem === view)
        XCTAssertTrue(constraintY.secondItem === superview)
        XCTAssertEqual(constraintY.firstAttribute, .centerY)
        XCTAssertEqual(constraintY.secondAttribute, .centerY)
        XCTAssertEqual(constraintY.constant, 5.5)
        XCTAssertEqual(constraintY.multiplier, 1)
    }
}
