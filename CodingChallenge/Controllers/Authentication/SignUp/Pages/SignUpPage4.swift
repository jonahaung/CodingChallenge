//
//  SignUpPage4.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SignUpPage4: SignUpPage {
    
    var loginUser: LoginUser?
    
    let textFieldContainerView: TextFieldContainerView = {
        $0.textField.isSecureTextEntry = true
        $0.textField.textContentType = .newPassword
        $0.textField.placeholder = "New password"
        return $0
    }(TextFieldContainerView(.none))
    
    let textFieldContainerViewRetype: TextFieldContainerView = {
        $0.textField.isSecureTextEntry = true
        $0.textField.textContentType = .newPassword
        $0.textField.placeholder = "Re enter password"
        return $0
    }(TextFieldContainerView(.none))
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "Create your login password"
        detailLabel.text = "Enter a combination of at least eight numbers which should should contain atleast 1 uppercase, 1 lowercase and 1 number"
        setButtonTitle(string: "Sign Up")
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textFieldContainerView)
        stackView.addArrangedSubview(textFieldContainerViewRetype)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(button)
        
        textFieldContainerView.textField.delegate = self
        textFieldContainerViewRetype.textField.delegate = self
        
        button.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = textFieldContainerView.becomeFirstResponder()
    }
    
    // Sign Up
    override func didTapButton(_ sender: UIButton?) {
        hideKeyboard()
        
        guard let password = textFieldContainerView.textField.text?.trimmed, !password.isEmpty else {
            self.textFieldContainerView.labelText = "Password shouldn't be empty"
            self.textFieldContainerView.textField.isValid = false
            return
        }
        
        // Match
        let isMatched = textFieldContainerView.textField.text == textFieldContainerViewRetype.textField.text
        
        guard isMatched else {
            self.textFieldContainerViewRetype.labelText = "Passwords did not match"
            self.textFieldContainerViewRetype.textField.isValid = false
            return
        }
        loginUser?.password = password
        
        guard let user = self.loginUser else { return }
        DBHelper.shared.insert(user: user)
        self.showAlert(title: "Sign Up Success", message: "You can now go and sign-in into the app", buttonText: "Okay", from: self) { ok in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideKeyboard()
    }
    
    private func hideKeyboard() {
        if textFieldContainerView.textField.isFirstResponder {
            _ = textFieldContainerView.resignFirstResponder()
        } else if textFieldContainerViewRetype.textField.isFirstResponder {
            _ = textFieldContainerViewRetype.resignFirstResponder()
        }
    }
}


// TextField Delegate

extension SignUpPage4: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        showButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textFieldContainerView.textField {
            _ = self.textFieldContainerViewRetype.becomeFirstResponder()
        } else {
            didTapButton(nil)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == self.textFieldContainerView.textField {
                self.textFieldContainerView.textField.isValid = updatedText.isValidPassword()
            } else {
                self.textFieldContainerViewRetype.textField.isValid = self.textFieldContainerView.textField.text == updatedText
            }
        }
        return true
    }
}
