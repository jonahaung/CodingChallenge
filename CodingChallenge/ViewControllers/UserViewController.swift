//
//  UserViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 22/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user?.name
        setup()
    }
}

extension UserViewController {
    private func setup(){
        view.backgroundColor = .systemBackground
    }
}
