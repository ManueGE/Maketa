//
//  LayoutTests.swift
//  LayoutTests
//
//  Created by Manuel García-Estañ on 13/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
@testable import Layout

class LayoutTests: XCTestCase {
    
    func testSingleLayoutObjectIsUsedForSameView() {
        // given
        let view = UIView()
        
        // when
        let layout1 = view.layout
        let layout2 = view.layout
        
        // then
        XCTAssertTrue(layout1.view === view)
        XCTAssertTrue(layout1 === layout2)
    }

    func testSuperLayoutObjectIsPorperlyReturned() {
        
        // given
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let layout1 = view.superLayout
        let layout2 = superview.layout
        
        // then
        XCTAssertTrue(layout1.view === superview)
        XCTAssertTrue(layout1 === layout2)
    }
    
    func testSingleSuperLayoutObjectIsUsedForSameView() {
        
        // given
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let layout1 = view.superLayout
        let layout2 = view.superLayout
        
        // then
        XCTAssertTrue(layout1 === layout2)
    }
}
