//
//  NavigationController.swift
//  BalarSarYwat
//
//  Created by Aung Ko Min on 1/11/19.
//  Copyright © 2019 Aung Ko Min. All rights reserved.
//

import UIKit
  
public class NavigationController: UINavigationController {

    private var isLoggedIn = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewControllers = isLoggedIn ? [UsersViewController()] : [LoginViewController()]
    }
}

extension NavigationController {
    
    private func setup(){
        navigationBar.prefersLargeTitles = true
        
    }
}
