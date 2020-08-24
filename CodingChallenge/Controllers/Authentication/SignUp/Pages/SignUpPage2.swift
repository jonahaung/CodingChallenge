//
//  SignUpPage2.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SignUpPage2: SignUpPage {
    
    let textFieldContainerView: TextFieldContainerView = {
        $0.textField.textContentType = .name
        $0.textField.placeholder = "Enter your full name"
        $0.textField.autocapitalizationType = .words
        $0.textField.returnKeyType = .go
        return $0
    }(TextFieldContainerView(.none))
    
    override func setup() {
        super.setup()
        
        titleLabel.text = "What is your name?"
        detailLabel.text = "Using your real name makes it easier for friends to recognise you."
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
    
    
    // Button Tapped
    override func didTapButton(_ sender: UIButton?) {
        _ = textFieldContainerView.resignFirstResponder()
        
        guard let name = textFieldContainerView.textField.text?.trimmed, !name.isEmpty else {
            self.textFieldContainerView.labelText = "Name shouldn't be empty"
            self.textFieldContainerView.textField.isValid = false
            return
        }
        var loginUser = LoginUser()
        loginUser.name = name
        let page3 = SignUpPage3()
        page3.loginUser = loginUser
        navigationController?.pushViewController(page3, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _ = textFieldContainerView.resignFirstResponder()
    }
}

// TextField Delegate

extension SignUpPage2: UITextFieldDelegate {
    
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
        self.textFieldContainerView.textField.rightImageName = string.lowercased() + ".circle.fill"
        return true
    }
}
