//
//  LoginViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        $0.bounces = true
        $0.alwaysBounceVertical = true
        $0.keyboardDismissMode = .onDrag
        return $0
    }(UIScrollView())
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoginViewController {
    fileprivate func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setup() {
        title = "Login"
        view.backgroundColor = .systemBackground
        let loginTitleView: UIImageView = {
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIImageView(image: UIImage(named: "welcome")))
       
        scrollView.addSubview(loginTitleView)
        loginTitleView.anchor(top: scrollView.topAnchor, paddingTop: 5, width: 250, height: 100)
        loginTitleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        scrollView.addSubview(loginView)
        loginView.anchor(top: loginTitleView.bottomAnchor, paddingTop: 15, left: scrollView.safeAreaLayoutGuide.leftAnchor, paddingLeft: 35, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingRight: 35)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: loginView, action: #selector(loginView.reset))

        let signUp = UIBarButtonItem(title: "Sign Up", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
        let resetPassword = UIBarButtonItem(title: "Reset Password", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
        toolbarItems = [signUp, UIBarButtonItem.flexible, resetPassword]
        
        setupKeyboardObserver()
    }
      
    //2
    @objc func keyboardWillShow(_ notification: Notification) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func didTapRightBarButtonItem(_ sender: UIBarButtonItem?) {
        let x = SignUpViewController()
        x.modalPresentationStyle = .fullScreen
        present(x, animated: true)
    }
}
