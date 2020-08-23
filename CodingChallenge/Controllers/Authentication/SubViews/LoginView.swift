//
//  LoginView.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoginView: UIStackView, AlertPresenting {
    
    let usernameTextField: LoginTextField = {
        return $0
    }(LoginTextField(.username))
    
    let passwordTextField: LoginTextField = {
        return $0
    }(LoginTextField(.password))
    
    let countryTextField: LoginTextField = {
        return $0
    }(LoginTextField(.country))
    
    private let button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.backgroundColor = UIColor.systemBlue
        let x = NSAttributedString(string: "Log In", attributes: [.foregroundColor: UIColor.systemBackground, .font: UIFont.preferredFont(forTextStyle: .title3)])
        $0.setAttributedTitle(x, for: .normal)
        $0.layer.cornerRadius = 8
        return $0
    }(UIButton(type: .system))
    
    private let bottomLabel: ActionLabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = .tertiaryLabel
        $0.textAlignment = .center
        $0.text = "Aung Ko Min\nhttps://github.com/jonahaung/CodingChallenge"
        return $0
    }(ActionLabel())
    

    private var currentTextField: LoginTextField?
    
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
        
        
        
        addArrangedSubview(usernameTextField)
        addArrangedSubview(passwordTextField)
        addArrangedSubview(countryTextField)
        addArrangedSubview(button)
        addArrangedSubview(UIView())
        addArrangedSubview(bottomLabel)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        countryTextField.delegate = self
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        bottomLabel.action { _ in
            if let url = URL(string: "https://github.com/jonahaung/CodingChallenge") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func reset() {
        currentTextField = nil
        usernameTextField.reset()
        passwordTextField.reset()
        countryTextField.reset()
    }
}

extension LoginView: LoginTextFieldDelegate {
    
    func loginTextField(textFieldDidBeginEditing textField: LoginTextField, type: LoginTextField.TextFieldType) {
        currentTextField = textField
    }
    
    func loginTextField(textFieldShouldReturn textField: LoginTextField, type: LoginTextField.TextFieldType) {
        _ = currentTextField?.resignFirstResponder()
    }
}

extension LoginView {
    
    @objc private func didTapLoginButton() {
        _ = currentTextField?.resignFirstResponder()
        guard let userName = usernameTextField.textField.text, !userName.isEmpty, let password = passwordTextField.textField.text, !password.isEmpty, let country = countryTextField.textField.text, !country.isEmpty else {
            showAlert(title: "Login Error", message: "make sure all fields are not empty")
            return
        }
        if let nav = self.parentViewController?.navigationController as? NavigationController {
            loading(true) {
                loading(false)
                nav.isLoggedIn.toggle()
            }
        }
    }
}
