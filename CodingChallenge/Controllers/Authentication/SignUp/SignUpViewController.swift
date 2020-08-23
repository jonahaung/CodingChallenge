//
//  SignUpViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

class SignUpViewController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
        setNavigationBarHidden(true, animated: false)
        
        let page1 = SignUpPage1()
        viewControllers = [page1]
    }
}
