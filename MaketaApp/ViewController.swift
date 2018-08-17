//
//  ViewController.swift
//  Maketa
//
//  Created by Manuel García-Estañ on 12/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit
import Maketa

class ViewController: UIViewController {
    
    var heightLayoutConstraint: NSLayoutConstraint?
    var heightLessLayoutConstraint: NSLayoutConstraint?
    var heightGreaterLayoutConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint!
    var globalCenterConstraints: CenterConstraints?
    var sizeConstraints: SizeConstraints?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view0 = UIView()
        view.addSubview(view0)
        view0.backgroundColor = .lightGray
        let insets = UIEdgeInsets(top: 20, left: 80, bottom: 20, right: 10)
        view0.mkt.edges = (view0.mkt.super.layoutDirectionEdges - insets - .bottom)
        view0.mkt.height = 200
        view0.mkt.height < 300 => heightLessLayoutConstraint
        view0.mkt.height > 100 => heightGreaterLayoutConstraint
        
        var constraint: NSLayoutConstraint = .empty
        let view1 = UIView()
        view.addSubview(view1)
        view1.backgroundColor = .red
        view1.mkt.height = (150 & .defaultLow) => heightLayoutConstraint
        view1.mkt.width = view1.mkt.height => constraint
        view1.mkt.centerX = view.mkt.centerX
        view1.mkt.centerY = view.mkt.centerY => centerYConstraint
        
        let view2 = UIView()
        view.addSubview(view2)
        view2.backgroundColor = .green
        view2.mkt.height = 20
        view2.mkt.width = view1.mkt.width * 0.5
        
        view2.mkt.top = view1.mkt.bottom + 10
        view2.mkt.centerX = view1.mkt.centerX - 30
        
        let view3 = UIView()
        view.addSubview(view3)
        view3.backgroundColor = .blue
        view3.mkt.aspectRatio = 2
        view3.mkt.top = view2.mkt.bottom + 10
        view3.mkt.centerX = view1.mkt.centerX
        view3.mkt.width = view1.mkt.width
        
        let view4 = UIView()
        view3.addSubview(view4)
        view4.backgroundColor = .white
        view4.mkt.center = (view3.mkt.center + 20) => globalCenterConstraints
        view4.mkt.size = (view2.mkt.size - 10) => sizeConstraints
    }
}

