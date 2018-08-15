//
//  EdgesTests.swift
//  LayoutTests
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
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.edges => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints[0]
        XCTAssertTrue(left.firstItem === view)
        XCTAssertTrue(left.secondItem === superview)
        XCTAssertEqual(left.firstAttribute, .left)
        XCTAssertEqual(left.secondAttribute, .left)
        XCTAssertEqual(left.multiplier, 1)
        XCTAssertEqual(left.constant, 0)
        XCTAssertEqual(left.relation, .equal)
        XCTAssertEqual(left.priority, .required)
        
        let right = constraints[1]
        XCTAssertTrue(right.firstItem === view)
        XCTAssertTrue(right.secondItem === superview)
        XCTAssertEqual(right.firstAttribute, .right)
        XCTAssertEqual(right.secondAttribute, .right)
        XCTAssertEqual(right.multiplier, 1)
        XCTAssertEqual(right.constant, 0)
        XCTAssertEqual(right.relation, .equal)
        XCTAssertEqual(right.priority, .required)
        
        let top = constraints[2]
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints[3]
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
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.margins => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints[0]
        XCTAssertTrue(left.firstItem === view)
        XCTAssertTrue(left.secondItem === superview)
        XCTAssertEqual(left.firstAttribute, .leftMargin)
        XCTAssertEqual(left.secondAttribute, .leftMargin)
        XCTAssertEqual(left.multiplier, 1)
        XCTAssertEqual(left.constant, 0)
        XCTAssertEqual(left.relation, .equal)
        XCTAssertEqual(left.priority, .required)
        
        let right = constraints[1]
        XCTAssertTrue(right.firstItem === view)
        XCTAssertTrue(right.secondItem === superview)
        XCTAssertEqual(right.firstAttribute, .rightMargin)
        XCTAssertEqual(right.secondAttribute, .rightMargin)
        XCTAssertEqual(right.multiplier, 1)
        XCTAssertEqual(right.constant, 0)
        XCTAssertEqual(right.relation, .equal)
        XCTAssertEqual(right.priority, .required)
        
        let top = constraints[2]
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.secondAttribute, .topMargin)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints[3]
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
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.layoutDirectionEdges => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let leading = constraints[0]
        XCTAssertTrue(leading.firstItem === view)
        XCTAssertTrue(leading.secondItem === superview)
        XCTAssertEqual(leading.firstAttribute, .leading)
        XCTAssertEqual(leading.secondAttribute, .leading)
        XCTAssertEqual(leading.multiplier, 1)
        XCTAssertEqual(leading.constant, 0)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.priority, .required)
        
        let trailing = constraints[1]
        XCTAssertTrue(trailing.firstItem === view)
        XCTAssertTrue(trailing.secondItem === superview)
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        XCTAssertEqual(trailing.secondAttribute, .trailing)
        XCTAssertEqual(trailing.multiplier, 1)
        XCTAssertEqual(trailing.constant, 0)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.priority, .required)
        
        let top = constraints[2]
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.secondAttribute, .top)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints[3]
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
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.layoutDirectionMargins => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let leading = constraints[0]
        XCTAssertTrue(leading.firstItem === view)
        XCTAssertTrue(leading.secondItem === superview)
        XCTAssertEqual(leading.firstAttribute, .leadingMargin)
        XCTAssertEqual(leading.secondAttribute, .leadingMargin)
        XCTAssertEqual(leading.multiplier, 1)
        XCTAssertEqual(leading.constant, 0)
        XCTAssertEqual(leading.relation, .equal)
        XCTAssertEqual(leading.priority, .required)
        
        let trailing = constraints[1]
        XCTAssertTrue(trailing.firstItem === view)
        XCTAssertTrue(trailing.secondItem === superview)
        XCTAssertEqual(trailing.firstAttribute, .trailingMargin)
        XCTAssertEqual(trailing.secondAttribute, .trailingMargin)
        XCTAssertEqual(trailing.multiplier, 1)
        XCTAssertEqual(trailing.constant, 0)
        XCTAssertEqual(trailing.relation, .equal)
        XCTAssertEqual(trailing.priority, .required)
        
        let top = constraints[2]
        XCTAssertTrue(top.firstItem === view)
        XCTAssertTrue(top.secondItem === superview)
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.secondAttribute, .topMargin)
        XCTAssertEqual(top.multiplier, 1)
        XCTAssertEqual(top.constant, 0)
        XCTAssertEqual(top.relation, .equal)
        XCTAssertEqual(top.priority, .required)
        
        let bottom = constraints[3]
        XCTAssertTrue(bottom.firstItem === view)
        XCTAssertTrue(bottom.secondItem === superview)
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.secondAttribute, .bottomMargin)
        XCTAssertEqual(bottom.multiplier, 1)
        XCTAssertEqual(bottom.constant, 0)
        XCTAssertEqual(bottom.relation, .equal)
        XCTAssertEqual(bottom.priority, .required)
    }
    
    
    // MARK: - Assignement
    func testCenterConstraintsCanBeAddedWithoutAssignment() {
        
        // given
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.edges
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
    }
    
    func testEdgesConstraintsCanBeAssignedToOptionalArray() {
        
        // given
        var constraints: [NSLayoutConstraint]?
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.edges => constraints
        
        // then
        XCTAssertEqual(constraints!.count, 4)
    }
    
    func testEdgesConstraintsCanBeAssignedToForcedUnwrappedArray() {
        
        // given
        var constraints: [NSLayoutConstraint]!
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = superview.layout.edges => constraints
        
        // then
        XCTAssertEqual(constraints.count, 4)
    }
    
    // MARK: - Exclude edge
    func testEdgesCanExcludeAnEdge() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.edges - .left) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        let right = constraints[0]
        XCTAssertEqual(right.firstAttribute, .right)
        
        let top = constraints[1]
        XCTAssertEqual(top.firstAttribute, .top)
        
        let bottom = constraints[2]
        XCTAssertEqual(bottom.firstAttribute, .bottom)
    }
    
    func testMarginsCanExcludeAnEdge() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.margins - .left) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        let rigth = constraints[0]
        XCTAssertEqual(rigth.firstAttribute, .rightMargin)
        
        let top = constraints[1]
        XCTAssertEqual(top.firstAttribute, .topMargin)
        
        let bottom = constraints[2]
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
    }
    
    func testLayoutDirectionEdgesCanExcludeAnEdge() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.layoutDirectionEdges - .leading) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        let trailing = constraints[0]
        XCTAssertEqual(trailing.firstAttribute, .trailing)
        
        let top = constraints[1]
        XCTAssertEqual(top.firstAttribute, .top)
        
        let bottom = constraints[2]
        XCTAssertEqual(bottom.firstAttribute, .bottom)
    }
    
    func testLayoutDirectionMarginsCanExcludeAnEdge() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.layoutDirectionMargins - .leading) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        let trailing = constraints[0]
        XCTAssertEqual(trailing.firstAttribute, .trailingMargin)
        
        let top = constraints[1]
        XCTAssertEqual(top.firstAttribute, .topMargin)
        
        let bottom = constraints[2]
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
    }
    
    func testEdgesExlcudingAnEdgeTwiceHasNotEffec() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.edges - .left - .left) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 3)
        
        let right = constraints[0]
        XCTAssertEqual(right.firstAttribute, .right)
        
        let top = constraints[1]
        XCTAssertEqual(top.firstAttribute, .top)
        
        let bottom = constraints[2]
        XCTAssertEqual(bottom.firstAttribute, .bottom)
    }
    
    // MARK: - Add padding
    func testCanAddPaddingToEdgesWithConstant() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.edges - 20) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)

        let left = constraints[0]
        XCTAssertEqual(left.firstAttribute, .left)
        XCTAssertEqual(left.constant, 20)
        
        let right = constraints[1]
        XCTAssertEqual(right.firstAttribute, .right)
        XCTAssertEqual(right.constant, -20)
        
        let top = constraints[2]
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.constant, 20)
        
        let bottom = constraints[3]
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.constant, -20)
    }
    
    func testCanAddPaddingToEdgesWithInsets() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.edges - UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 25)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints[0]
        XCTAssertEqual(left.firstAttribute, .left)
        XCTAssertEqual(left.constant, 15)
        
        let right = constraints[1]
        XCTAssertEqual(right.firstAttribute, .right)
        XCTAssertEqual(right.constant, -25)
        
        let top = constraints[2]
        XCTAssertEqual(top.firstAttribute, .top)
        XCTAssertEqual(top.constant, 10)
        
        let bottom = constraints[3]
        XCTAssertEqual(bottom.firstAttribute, .bottom)
        XCTAssertEqual(bottom.constant, -20)
    }
    
    func testCanAddPaddingToMarginsWithConstant() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.margins - 20) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints[0]
        XCTAssertEqual(left.firstAttribute, .leftMargin)
        XCTAssertEqual(left.constant, 20)
        
        let right = constraints[1]
        XCTAssertEqual(right.firstAttribute, .rightMargin)
        XCTAssertEqual(right.constant, -20)
        
        let top = constraints[2]
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.constant, 20)
        
        let bottom = constraints[3]
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.constant, -20)
    }
    
    func testCanAddPaddingToMarginsWithInsets() {
        // given
        var constraints: [NSLayoutConstraint] = []
        let view = UIView()
        superview.addSubview(view)
        
        // when
        view.layout.edges = (superview.layout.margins - UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 25)) => constraints
        
        // then
        XCTAssertEqual(superview.constraints.count, 4)
        
        let left = constraints[0]
        XCTAssertEqual(left.firstAttribute, .leftMargin)
        XCTAssertEqual(left.constant, 15)
        
        let right = constraints[1]
        XCTAssertEqual(right.firstAttribute, .rightMargin)
        XCTAssertEqual(right.constant, -25)
        
        let top = constraints[2]
        XCTAssertEqual(top.firstAttribute, .topMargin)
        XCTAssertEqual(top.constant, 10)
        
        let bottom = constraints[3]
        XCTAssertEqual(bottom.firstAttribute, .bottomMargin)
        XCTAssertEqual(bottom.constant, -20)
    }
}
