//
//  SignUpPage4.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SignUpPage4: SignUpPage {

    var isValid: Bool {
        return (textField.textField.text == textField2.textField.text) && textField.textField.hasText
    }
    var loginUser: LoginUser?
    let textField: LoginTextField = {
        $0.textField.isSecureTextEntry = true
        $0.textField.textContentType = .newPassword
        $0.textField.placeholder = "Enter your new password"
        return $0
    }(LoginTextField(.none))
    let textField2: LoginTextField = {
        $0.textField.isSecureTextEntry = true
        $0.textField.textContentType = .newPassword
        $0.textField.placeholder = "Comfirm your password"
        return $0
    }(LoginTextField(.none))
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "Create your login password"
        detailLabel.text = "Please make sure that the two passwords are same. Password should be at least 6 characters."
        setButtonTitle(string: "Sign Up")
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textField2)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(button)
        
        textField.textField.delegate = self
        textField2.textField.delegate = self
        
        button.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = textField.becomeFirstResponder()
    }
    
    override func didTapButton(_ sender: UIButton?) {
        setEditing(false, animated: true)
        loginUser?.password = textField.textField.text ?? ""
        if isValid {
            AuthManager.shared.currentUser = loginUser
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = textField.resignFirstResponder()
    }
    
    
    
}

extension SignUpPage4: UITextFieldDelegate {
    
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
        if isValid {
            UIView.animate(withDuration: 0.3) {
                self.detailLabel.isHidden = true
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.button.isHidden = false
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.hasText else { return false }
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.textField.textField {
            self.textField.textField.isValid = range.location > 4
        } else {
            self.textField2.textField.isValid = range.location > 4
        }
        
        return true
    }
}
