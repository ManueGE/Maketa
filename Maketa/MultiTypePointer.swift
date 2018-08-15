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
    private let forcedUnwrappedPointer: UnsafeMutablePointer<Pointee!>?
    
    init(_ pointee: inout Pointee) {
        pointer = UnsafeMutablePointer(&pointee)
        optionalPointer = nil
        forcedUnwrappedPointer = nil
    }
    
    init(withOptional pointee: inout Pointee?) {
        pointer = nil
        optionalPointer = UnsafeMutablePointer(&pointee)
        forcedUnwrappedPointer = nil
    }
    
    init(withForcedUnwrapped pointee: inout Pointee!) {
        pointer = nil
        optionalPointer = nil
        forcedUnwrappedPointer = UnsafeMutablePointer(&pointee)
    }
    
    func setPointee(_ pointee: Pointee) {
        pointer?.pointee = pointee
        optionalPointer?.pointee = pointee
        forcedUnwrappedPointer?.pointee = pointee
    }
}
