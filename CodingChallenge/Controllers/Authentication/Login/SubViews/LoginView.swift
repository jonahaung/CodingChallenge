//
//  LoginView.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoginView: UIStackView, AlertPresenting {
    
    let emailTextInputView: TextFieldContainerView = {
        return $0
    }(TextFieldContainerView(.email))
    
    let passwordInputView: TextFieldContainerView = {
        return $0
    }(TextFieldContainerView(.password))
    
    let countryTextField: TextFieldContainerView = {
        return $0
    }(TextFieldContainerView(.country))
    
    private let button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.systemBlue
        let x = NSAttributedString(string: "Log In", attributes: [.foregroundColor: UIColor.systemBackground, .font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        $0.setAttributedTitle(x, for: .normal)
        $0.layer.cornerRadius = 8
        return $0
    }(UIButton(type: .system))
    
    private let bottomLabel: ActionLabel = {
        $0.numberOfLines = 0
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = .tertiaryLabel
        $0.textAlignment = .center
        $0.text = "Aung Ko Min\nhttps://github.com/jonahaung/CodingChallenge"
        return $0
    }(ActionLabel())
    

    private var currentTextField: TextFieldContainerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        spacing = 20
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(emailTextInputView)
        addArrangedSubview(passwordInputView)
        addArrangedSubview(countryTextField)
        addArrangedSubview(button)
        addArrangedSubview(UIView())
        addArrangedSubview(bottomLabel)
        
        emailTextInputView.delegate = self
        passwordInputView.delegate = self
        countryTextField.delegate = self
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    
    }
    
    @objc func reset() {
        currentTextField = nil
        emailTextInputView.reset()
        passwordInputView.reset()
        countryTextField.reset()
    }
}

extension LoginView: TextFieldContainerViewDelegate {
    
    func textFieldContainerViewDelegate(textFieldDidBeginEditing textField: TextFieldContainerView, type: TextFieldContainerView.TextFieldType) {
        currentTextField = textField
    }
    
    func textFieldContainerViewDelegate(textFieldShouldReturn textField: TextFieldContainerView, type: TextFieldContainerView.TextFieldType) {
        _ = currentTextField?.resignFirstResponder()
    }
}

extension LoginView {
    
    // login
    @objc private func didTapLoginButton() {
        _ = currentTextField?.resignFirstResponder()
        guard let email = emailTextInputView.textField.text?.trimmed, !email.isEmpty else {
            emailTextInputView.labelText = "Email address is empty"
            return
        }
        
        guard email.isValidEmail() else {
            emailTextInputView.labelText = "Email is not valid"
            return
        }
        
        guard let password = passwordInputView.textField.text?.trimmed, !password.isEmpty else {
            passwordInputView.labelText = "Password is empty"
            return
        }
        
        guard var user = DBHelper.shared.getUser(email: email, password: password) else {
            showAlert(title: "Error", message: "Email or password does not match")
            return
        }
        
        user.courntry = countryTextField.textField.text ?? ""
        DBHelper.shared.updateUser(user: user)
        loading(true, delay: 0.5) {
            loading(false)
            AuthManager.shared.signIn(with: user)
        }
    }
}
