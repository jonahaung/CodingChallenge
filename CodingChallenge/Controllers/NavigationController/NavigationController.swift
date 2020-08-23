//
//  NavigationController.swift
//  BalarSarYwat
//
//  Created by Aung Ko Min on 1/11/19.
//  Copyright © 2019 Aung Ko Min. All rights reserved.
//

import UIKit
  
public class NavigationController: UINavigationController {

    var isLoggedIn = true {
        didSet {
            guard oldValue != isLoggedIn else { return }
            let vcs = isLoggedIn ? [UsersViewController()] : [LoginViewController()]
            viewControllers = vcs
            
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        isLoggedIn = false
    }
}

extension NavigationController {
    
    private func setup(){
        navigationBar.prefersLargeTitles = true
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolbar.clipsToBounds = true
        toolbar.isTranslucent = false
    }
}
