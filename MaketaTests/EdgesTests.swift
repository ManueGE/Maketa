//
//  EdgesTests.swift
//  MaketaTests
//
//  Created by Manuel García-Estañ on 15/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
@testable import Maketa

class EdgesTests: ConstraintsTestCase {
    
    // MARK: - Basic
    func testEdgesCanBeSetWithEdges() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.edges => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints.left!
        XCTAssertTrue(left.firstItem === view)
        XCTAssertTrue(left.secondItem === superview)
        XCTAssertEqual(left.firstAttribute, .left)
        XCTAssertEqual(left.secondAttribute, .left)
        XCTAssertEqual(left.multiplier, 1)
        XCTAssertEqual(left.constant, 0)
        XCTAssertEqual(left.relation, .equal)
        XCTAssertEqual(left.priority, .required)
        
        let right = constraints.right!
        XCTAssertTrue(right.firstItem === view)
        XCTAssertTrue(right.secondItem === superview)
        XCTAssertEqual(right.firstAttribute, .right)
        XCTAssertEqual(right.secondAttribute, .right)
        XCTAssertEqual(right.multiplier, 1)
        XCTAssertEqual(right.constant, 0)
        XCTAssertEqual(right.relation, .equal)
        XCTAssertEqual(right.priority, .required)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints.bottom!
        XCTAssertTrue(bottom.firstItem === view)
        XCTAssertTrue(bottom.secondItem === superview)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
        XCTAssertEqual(bottom.multiplier, 1)
        XCTAssertEqual(bottom.constant, 0)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.priority, .required)
    }
    
    func testEdgesCanBeSetWithMargins() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.margins => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints.left!
        XCTAssertTrue(left.firstItem === view)
        XCTAssertTrue(left.secondItem === superview)
        XCTAssertEqual(left.firstAttribute, .leftMargin)
        XCTAssertEqual(left.secondAttribute, .leftMargin)
        XCTAssertEqual(left.multiplier, 1)
        XCTAssertEqual(left.constant, 0)
        XCTAssertEqual(left.relation, .equal)
        XCTAssertEqual(left.priority, .required)
        
        let right = constraints.right!
        XCTAssertTrue(right.firstItem === view)
        XCTAssertTrue(right.secondItem === superview)
        XCTAssertEqual(right.firstAttribute, .rightMargin)
        XCTAssertEqual(right.secondAttribute, .rightMargin)
        XCTAssertEqual(right.multiplier, 1)
        XCTAssertEqual(right.constant, 0)
        XCTAssertEqual(right.relation, .equal)
        XCTAssertEqual(right.priority, .required)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.secondAttribute, .topMargin)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints.bottom!
        XCTAssertTrue(bottom.firstItem === view)
        XCTAssertTrue(bottom.secondItem === superview)
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.secondAttribute, .bottomMargin)
        XCTAssertEqual(bottom.multiplier, 1)
        XCTAssertEqual(bottom.constant, 0)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.priority, .required)
    }
    
    // MARK: - Relative to interface layout direnction
    func testEdgesCanBeSetWithEdgesRelativeToInterfaceLayoutDirection() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.layoutDirectionEdges => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        XCTAssertNil(constraints.left)
        
        XCTAssertNil(constraints.right)
        
        let leading = constraints.leading!
        XCTAssertTrue(leading.firstItem === view)
        XCTAssertTrue(leading.secondItem === superview)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)
        XCTAssertEqual(leading.multiplier, 1)
        XCTAssertEqual(leading.constant, 0)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.priority, .required)
        
        let trailing = constraints.trailing!
        XCTAssertTrue(trailing.firstItem === view)
        XCTAssertTrue(trailing.secondItem === superview)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
        XCTAssertEqual(trailing.multiplier, 1)
        XCTAssertEqual(trailing.constant, 0)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.priority, .required)
        
        let top = constraints.top!
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints.bottom!
        XCTAssertTrue(bottom.firstItem === view)
        XCTAssertTrue(bottom.secondItem === superview)
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.secondAttribute, .bottom)
        XCTAssertEqual(bottom.multiplier, 1)
        XCTAssertEqual(bottom.constant, 0)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.priority, .required)
    }
    
    func testEdgesCanBeSetWithMarginsRelativeToInterfaceLayoutDirection() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.layoutDirectionMargins => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        XCTAssertNil(constraints.left)
        
        XCTAssertNil(constraints.right)
        
        let leading = constraints.leading!
        XCTAssertTrue(leading.firstItem === view)
        XCTAssertTrue(leading.secondItem === superview)
        XCTAssertEqual(leading.firstAttribute, .leadingMargin)
        XCTAssertEqual(leading.secondAttribute, .leadingMargin)
        XCTAssertEqual(leading.multiplier, 1)
        XCTAssertEqual(leading.constant, 0)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.priority, .required)
        
        let trailing = constraints.trailing!
        XCTAssertTrue(trailing.firstItem === view)
        XCTAssertTrue(trailing.secondItem === superview)
        XCTAssertEqual(trailing.firstAttribute, .trailingMargin)
        XCTAssertEqual(trailing.secondAttribute, .trailingMargin)
        XCTAssertEqual(trailing.multiplier, 1)
        XCTAssertEqual(trailing.constant, 0)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.priority, .required)
        
        let top = constraints.top!
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.secondAttribute, .topMargin)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints.bottom!
        XCTAssertTrue(bottom.firstItem === view)
        XCTAssertTrue(bottom.secondItem === superview)
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.secondAttribute, .bottomMargin)
        XCTAssertEqual(bottom.multiplier, 1)
        XCTAssertEqual(bottom.constant, 0)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.priority, .required)
    }
    
    // MARK: - Relations
    func testEqualRelationship() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.edges => constraints
        
        // then
        XCTAssertEqual(constraints.left!.relation, .equal)
        XCTAssertEqual(constraints.right!.relation, .equal)
        XCTAssertNil(constraints.leading)
        XCTAssertNil(constraints.trailing)
        XCTAssertEqual(constraints.top!.relation, .equal)
        XCTAssertEqual(constraints.bottom!.relation, .equal)
    }
    
    func testLessThanRelationship() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges < superview.mkt.edges => constraints
        
        // then
        XCTAssertEqual(constraints.left!.relation, .lessThanOrEqual)
        XCTAssertEqual(constraints.right!.relation, .lessThanOrEqual)
        XCTAssertNil(constraints.leading)
        XCTAssertNil(constraints.trailing)
        XCTAssertEqual(constraints.top!.relation, .lessThanOrEqual)
        XCTAssertEqual(constraints.bottom!.relation, .lessThanOrEqual)
    }
    
    func testGreaterThanRelationship() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges > superview.mkt.edges => constraints
        
        // then
        XCTAssertEqual(constraints.left!.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints.right!.relation, .greaterThanOrEqual)
        XCTAssertNil(constraints.leading)
        XCTAssertNil(constraints.trailing)
        XCTAssertEqual(constraints.top!.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints.bottom!.relation, .greaterThanOrEqual)
    }
    
    // MARK: - Priority
    func testCustomPriority() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.edges & .defaultLow) => constraints
        
        // then
        XCTAssertEqual(constraints.left!.priority, .defaultLow)
        XCTAssertEqual(constraints.right!.priority, .defaultLow)
        XCTAssertNil(constraints.leading)
        XCTAssertNil(constraints.trailing)
        XCTAssertEqual(constraints.top!.priority, .defaultLow)
        XCTAssertEqual(constraints.bottom!.priority, .defaultLow)
    }
    
    // MARK: - Assignement
    func testCenterConstraintsCanBeAddedWithoutAssignment() {
        
        // given
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.edges
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
    }
    
    func testEdgesConstraintsCanBeAssignedToOptionalConstraints() {
        
        // given
        var constraints: EdgesConstraints?
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.edges => constraints
        
        // then
        XCTAssertNotNil(constraints)
    }
    
    func testEdgesConstraintsCanBeAssignedToForcedUnwrappedConstraints() {
        
        // given
        var constraints: EdgesConstraints!
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = superview.mkt.edges => constraints
        
        // then
        XCTAssertNotNil(constraints)
    }
    
    // MARK: - Exclude edge
    func testEdgesCanExcludeAnEdge() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.edges - .left) => constraints
        
        // then
        
        XCTAssertNil(constraints.left)
        
        let right = constraints.right!
        XCTAssertEqual(right.firstAttribute, .right)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .top)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottom)
    }
    
    func testMarginsCanExcludeAnEdge() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.margins - .left) => constraints
        
        // then
        
        XCTAssertNil(constraints.left)
        
        let rigth = constraints.right!
        XCTAssertEqual(rigth.firstAttribute, .rightMargin)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .topMargin)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
    }
    
    func testLayoutDirectionEdgesCanExcludeAnEdge() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.layoutDirectionEdges - .leading) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        XCTAssertNil(constraints.left)
        
        XCTAssertNil(constraints.right)
        
        XCTAssertNil(constraints.leading)
        
        let trailing = constraints.trailing!
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .top)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottom)
    }
    
    func testLayoutDirectionMarginsCanExcludeAnEdge() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.layoutDirectionMargins - .leading) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        XCTAssertNil(constraints.left)
        
        XCTAssertNil(constraints.right)
        
        XCTAssertNil(constraints.leading)
        
        let trailing = constraints.trailing!
        XCTAssertEqual(trailing.firstAttribute, .trailingMargin)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .topMargin)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
    }
    
    func testEdgesExlcudingAnEdgeTwiceHasNotEffect() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.edges - .left - .left) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        XCTAssertNil(constraints.left)
        
        let right = constraints.right!
        XCTAssertEqual(right.firstAttribute, .right)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .top)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottom)
    }
    
    // MARK: - Add padding
    func testCanAddPaddingToEdgesWithConstant() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.edges - 20) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)

        let left = constraints.left!
        XCTAssertEqual(left.firstAttribute, .left)
        XCTAssertEqual(left.constant, 20)
        
        let right = constraints.right!
        XCTAssertEqual(right.firstAttribute, .right)
        XCTAssertEqual(right.constant, -20)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.constant, 20)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.constant, -20)
    }
    
    func testCanAddPaddingToEdgesWithInsets() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.edges - UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 25)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints.left!
        XCTAssertEqual(left.firstAttribute, .left)
        XCTAssertEqual(left.constant, 15)
        
        let right = constraints.right!
        XCTAssertEqual(right.firstAttribute, .right)
        XCTAssertEqual(right.constant, -25)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.constant, 10)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.constant, -20)
    }
    
    func testCanAddPaddingToMarginsWithConstant() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.margins - 20) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints.left!
        XCTAssertEqual(left.firstAttribute, .leftMargin)
        XCTAssertEqual(left.constant, 20)
        
        let right = constraints.right!
        XCTAssertEqual(right.firstAttribute, .rightMargin)
        XCTAssertEqual(right.constant, -20)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.constant, 20)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.constant, -20)
    }
    
    func testCanAddPaddingToMarginsWithInsets() {
        // given
        var constraints = EdgesConstraints()
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.mkt.edges = (superview.mkt.margins - UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 25)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints.left!
        XCTAssertEqual(left.firstAttribute, .leftMargin)
        XCTAssertEqual(left.constant, 15)
        
        let right = constraints.right!
        XCTAssertEqual(right.firstAttribute, .rightMargin)
        XCTAssertEqual(right.constant, -25)
        
        XCTAssertNil(constraints.leading)
        
        XCTAssertNil(constraints.trailing)
        
        let top = constraints.top!
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.constant, 10)
        
        let bottom = constraints.bottom!
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.constant, -20)
    }
}
