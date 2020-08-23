//
//  LoginViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        $0.bounces = true
        $0.alwaysBounceVertical = true
        $0.keyboardDismissMode = .onDrag
        return $0
    }(UIScrollView())
    
    let loginView = LoginView()
    
    override func loadView() {
        view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        loginView.anchor(top: loginTitleView.bottomAnchor, paddingTop: 15, left: scrollView.safeAreaLayoutGuide.leftAnchor, paddingLeft: 30, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingRight: 30)
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: loginView, action: #selector(loginView.reset))
        setupKeyboardObserver()
    }
      
    //2
    @objc func keyboardWillShow(_ notification: Notification) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
