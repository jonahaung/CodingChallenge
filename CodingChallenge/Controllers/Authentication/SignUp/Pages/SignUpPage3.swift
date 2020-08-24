//
//  SignUpPage3.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SignUpPage3: SignUpPage {
    
    var loginUser: LoginUser?
    
    let textField: LoginTextField = {
        $0.textField.textContentType = .emailAddress
        $0.textField.placeholder = "Enter your email address"
        $0.textField.autocapitalizationType = .none
        $0.textField.keyboardType = .emailAddress
        return $0
    }(LoginTextField(.none))
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "What is your email address?"
        detailLabel.text = "You will use this email address when you log in and if you ever need to reset your password."
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
        _ = textField.resignFirstResponder()
        loginUser?.email = self.textField.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let page4 = SignUpPage4()
        page4.loginUser = loginUser
        navigationController?.pushViewController(page4, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = textField.resignFirstResponder()
    }

}

extension SignUpPage3: UITextFieldDelegate {
    
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
        guard textField.hasText else { return false }
        didTapButton(nil)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.textField.textField.isValid = textField.text?.isValidEmail() == true
        return true
    }
}
