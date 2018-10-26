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
        let maketa1 = view.mkt
        let maketa2 = view.mkt
        
        // then
        XCTAssertTrue(maketa1.view === view)
        XCTAssertTrue(maketa1 === maketa2)
    }

	@available(*, deprecated)
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
	
	@available(*, deprecated)
    func testSingleSuperLayoutObjectIsUsedForSameView() {
        
        // given
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let maketa1 = view.mkt.super
        let maketa2 = view.mkt.super
        
        // then
        XCTAssertTrue(maketa1 === maketa2)
    }
}
