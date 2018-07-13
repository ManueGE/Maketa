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
    var centerYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var constraint: NSLayoutConstraint = .empty
        let view1 = UIView()
        view.addSubview(view1)
        view1.backgroundColor = .red
        view1.layout.height = (150 & UILayoutPriority.defaultLow) >>> heightLayoutConstraint
        view1.layout.width = view1.layout.height >>> constraint
        view1.layout.centerX = view.layout.centerX
        view1.layout.centerY = view.layout.centerY >>> centerYConstraint
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

