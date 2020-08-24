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
            guard oldValue != currentUser else { return }
            SceneDelegate.delegate?.navigationController?.isLoggedIn = currentUser != nil
        }
    }
    
    var isLoggedIn: Bool { currentUser != nil }
    
    
    func signIn(with email: String, password: String) {
        currentUser = LoginUser(name: "Aung Ko Min", email: email, password: password)
    }
    
    func signOut() {
        currentUser = nil
    }
}
