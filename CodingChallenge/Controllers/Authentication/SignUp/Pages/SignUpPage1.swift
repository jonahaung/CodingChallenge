//
//  SignUpPage1.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SignUpPage1: SignUpPage {
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "Join Coding Chellenge"
        detailLabel.text = "We'll help you create an account in a few easy steps"
        setButtonTitle(string: "Get Started")
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(button)
    }

    override func didTapButton(_ sender: UIButton?) {
        navigationController?.pushViewController(SignUpPage2(), animated: true)
    }
}
