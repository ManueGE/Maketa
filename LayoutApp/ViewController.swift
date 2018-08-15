//
//  ViewController.swift
//  Layout
//
//  Created by Manuel García-Estañ on 12/7/18.
//  Copyright © 2018 Manue. All rights reserved.
//

import UIKit
import Layout

class ViewController: UIViewController {
    
    var heightLayoutConstraint: NSLayoutConstraint?
    var heightLessLayoutConstraint: NSLayoutConstraint?
    var heightGreaterLayoutConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint!
    var globalCenterConstraints: [NSLayoutConstraint]?
    var sizeConstraints: [NSLayoutConstraint]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view0 = UIView()
        view.addSubview(view0)
        view0.backgroundColor = .lightGray
        view0.layout.edges = (view0.superLayout.edges - 40 - .bottom) => globalCenterConstraints
        view0.layout.height = 200
        view0.layout.height < 300 => heightLessLayoutConstraint
        view0.layout.height > 100 => heightGreaterLayoutConstraint
        
        var constraint: NSLayoutConstraint = .empty
        let view1 = UIView()
        view.addSubview(view1)
        view1.backgroundColor = .red
        view1.layout.height = (150 & .defaultLow) => heightLayoutConstraint
        view1.layout.width = view1.layout.height => constraint
        view1.layout.centerX = view.layout.centerX
        view1.layout.centerY = view.layout.centerY => centerYConstraint
        
        let view2 = UIView()
        view.addSubview(view2)
        view2.backgroundColor = .green
        view2.layout.height = 20
        view2.layout.width = view1.layout.width * 0.5
        
        view2.layout.top = view1.layout.bottom + 10
        view2.layout.centerX = view1.layout.centerX - 30
        
        let view3 = UIView()
        view.addSubview(view3)
        view3.backgroundColor = .blue
        view3.layout.aspectRatio = 2
        view3.layout.top = view2.layout.bottom + 10
        view3.layout.centerX = view1.layout.centerX
        view3.layout.width = view1.layout.width
        
        let view4 = UIView()
        view3.addSubview(view4)
        view4.backgroundColor = .white
        view4.layout.center = (view3.layout.center + 20) => globalCenterConstraints
        view4.layout.size = (view2.layout.size - 10) => sizeConstraints
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

