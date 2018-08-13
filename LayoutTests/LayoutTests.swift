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
        let view = UIView()
        let layout1 = view.layout
        let layout2 = view.layout
        XCTAssertTrue(layout1 === layout2)
    }
    
    func testSingleSuperLayoutObjectIsUsedForSameView() {
        let view = UIView()
        let superview = UIView()
        
        superview.addSubview(view)
        
        let layout1 = view.superLayout
        let layout2 = view.superLayout
        XCTAssertTrue(layout1 === layout2)
    }
}
