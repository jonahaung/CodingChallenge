//
//  AuthManager.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    var currentUser: LoginUser? {
        didSet {
            SceneDelegate.delegate?.navigationController?.viewControllers = currentUser == nil ? [LoginViewController()] : [UsersViewController()]
        }
    }
    
    func signIn(with user: LoginUser) {
        currentUser = user
        UserDefaults.standard.setValue(user.email, forKey: "email")
    }
    
    func signOut() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
    func obsrveAuthState() {
        if let email = UserDefaults.standard.string(forKey: "email"), let loginUser = DBHelper.shared.getUser(email: email), let confirmedUser = DBHelper.shared.getUser(email: loginUser.email, password: loginUser.password) {
            signIn(with: confirmedUser)
        } else {
            currentUser = nil
        }
    }
}
