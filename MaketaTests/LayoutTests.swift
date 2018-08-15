//
//  MaketaTests.swift
//  MaketaTests
//
//  Created by Manuel García-Estañ on 13/8/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import XCTest
@testable import Maketa

class LayoutTests: XCTestCase {
    
    func testSingleMaketaObjectIsUsedForSameView() {
        // given
        let view = UIView()
        
        // when
        let layout1 = view.mkt
        let layout2 = view.mkt
        
        // then
        XCTAssertTrue(layout1.view === view)
        XCTAssertTrue(layout1 === layout2)
    }

    func testSuperMaketaObjectIsPorperlyReturned() {
        
        // given
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let maketa1 = view.mkt.super
        let maketa2 = superview.mkt
        
        // then
        XCTAssertTrue(maketa1.view === superview)
        XCTAssertTrue(maketa1 === maketa2)
    }
    
    func testSingleSuperLayoutObjectIsUsedForSameView() {
        
        // given
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let layout1 = view.mkt.super
        let layout2 = view.mkt.super
        
        // then
        XCTAssertTrue(layout1 === layout2)
    }
}
