//
//  SignUpPage2.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SignUpPage2: SignUpPage {
    
    let textField: LoginTextField = {
        $0.textField.textContentType = .name
        $0.textField.placeholder = "your full name"
        $0.textField.autocapitalizationType = .words
        $0.textField.returnKeyType = .go
        return $0
    }(LoginTextField(.none))
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "What is your name?"
        detailLabel.text = "Using your real name makes it easier for friends to recognise you."
        setButtonTitle(string: "Next")
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(button)
        
        textField.textField.delegate = self
        
        button.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = textField.becomeFirstResponder()
    }
    
    override func didTapButton(_ sender: UIButton?) {
        navigationController?.pushViewController(SignUpPage3(), animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = textField.resignFirstResponder()
    }
}

extension SignUpPage2: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) {
            self.button.alpha = 0.0
            self.detailLabel.isHidden = false
        } completion: { _ in
            self.button.isHidden = true
            self.button.alpha = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.detailLabel.isHidden = true
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.button.isHidden = false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        navigationController?.pushViewController(SignUpPage3(), animated: true)
        return true
    }
}
