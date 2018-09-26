//
//  MultiTypePointer.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 14/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import Foundation

struct MultiTypePointer<Pointee> {
    
    private let pointer: UnsafeMutablePointer<Pointee>?
    private let optionalPointer: UnsafeMutablePointer<Pointee?>?
    
    init(_ pointee: inout Pointee) {
        pointer = UnsafeMutablePointer(&pointee)
        optionalPointer = nil
    }
    
    init(withOptional pointee: inout Pointee?) {
        pointer = nil
        optionalPointer = UnsafeMutablePointer(&pointee)
    }
	
    func setPointee(_ pointee: Pointee) {
        pointer?.pointee = pointee
        optionalPointer?.pointee = pointee
    }
}
