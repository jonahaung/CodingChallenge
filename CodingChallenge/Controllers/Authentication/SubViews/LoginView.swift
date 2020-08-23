//
//  LoginView.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoginView: UIStackView {
    
    let usernameTextField: LoginTextField = {
        return $0
    }(LoginTextField(.username))
    
    let passwordTextField: LoginTextField = {
        return $0
    }(LoginTextField(.password))
    
    let countryTextField: LoginTextField = {
        return $0
    }(LoginTextField(.country))
    
    let button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
       
        $0.backgroundColor = UIColor.systemBlue
        let x = NSAttributedString(string: "Log In", attributes: [.foregroundColor: UIColor.systemBackground, .font: UIFont.preferredFont(forTextStyle: .title3)])
        $0.setAttributedTitle(x, for: .normal)
        $0.layer.cornerRadius = 5
        return $0
    }(UIButton(type: .custom))
    

    private var currentTextField: LoginTextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        spacing = 15
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
        
        let signUpLabel: ActionLabel = {
            $0.textAlignment = .center
            let attr = NSMutableAttributedString(string: "Are you a new user? ", attributes: [.foregroundColor: UIColor.secondaryLabel, .font: UIFont.preferredFont(forTextStyle: .footnote)])
            attr.append(NSAttributedString(string: "sign up now!", attributes: [.foregroundColor: UIColor.systemBlue, .font: UIFont.preferredFont(forTextStyle: .footnote)]))
            $0.attributedText = attr
            $0.action { _ in
                self.parentViewController?.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }
            return $0
        }(ActionLabel())
        let forgetPasswordLabel: ActionLabel = {
            $0.textAlignment = .center
            let attr = NSMutableAttributedString(string: "Login problems? ", attributes: [.foregroundColor: UIColor.secondaryLabel, .font: UIFont.preferredFont(forTextStyle: .footnote)])
            attr.append(NSAttributedString(string: "reset password", attributes: [.foregroundColor: UIColor.systemBlue, .font: UIFont.preferredFont(forTextStyle: .footnote)]))
            $0.attributedText = attr
            $0.action { _ in
                self.parentViewController?.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }
            return $0
        }(ActionLabel())
        
        addArrangedSubview(usernameTextField)
        addArrangedSubview(passwordTextField)
        addArrangedSubview(countryTextField)
        addArrangedSubview(button)
        addArrangedSubview(UIView())
        addArrangedSubview(signUpLabel)
        addArrangedSubview(forgetPasswordLabel)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        countryTextField.delegate = self
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if let nav = parentViewController?.navigationController as? NavigationController {
            nav.isLoggedIn.toggle()
        }
    }
}
