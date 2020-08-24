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
    
    let textFieldContainerView: TextFieldContainerView = {
        $0.textField.textContentType = .emailAddress
        $0.textField.placeholder = "Enter your email address"
        $0.textField.autocapitalizationType = .none
        $0.textField.keyboardType = .emailAddress
        return $0
    }(TextFieldContainerView(.none))
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "What is your email address?"
        detailLabel.text = "You will use this email address when you log in and if you ever need to reset your password."
        setButtonTitle(string: "Next")
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textFieldContainerView)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(button)
        
        textFieldContainerView.textField.delegate = self
        
        button.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = textFieldContainerView.becomeFirstResponder()
    }
    
    override func didTapButton(_ sender: UIButton?) {
        _ = textFieldContainerView.resignFirstResponder()
        
        guard let email = textFieldContainerView.textField.text?.trimmed else {
            self.textFieldContainerView.labelText = "Email shouldn't be empty"
            self.textFieldContainerView.textField.isValid = false
            return
        }
        
        let isValid = email.isValidEmail()
        
        guard isValid else {
            self.textFieldContainerView.labelText = "Email address is not valid"
            self.textFieldContainerView.textField.isValid = false
            return
        }
        
        if DBHelper.shared.isEmailExisted(for: email) {
            self.textFieldContainerView.labelText = "Email has already registered"
            self.textFieldContainerView.textField.isValid = false
            return
        }
        
        loginUser?.email = email
        let page4 = SignUpPage4()
        page4.loginUser = loginUser
        navigationController?.pushViewController(page4, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _ = textFieldContainerView.resignFirstResponder()
    }
    
}

// TextField Delegate

extension SignUpPage3: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        showButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapButton(nil)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.textFieldContainerView.textField.isValid = updatedText.isValidEmail()
        }
        return true
    }
}
