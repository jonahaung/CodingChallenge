//
//  LoginTextFieldDelegate.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

protocol LoginTextFieldDelegate: class {
    func loginTextField(textFieldDidBeginEditing textField: LoginTextField,  type: LoginTextField.TextFieldType)
    func loginTextField(textFieldShouldReturn textField: LoginTextField, type: LoginTextField.TextFieldType)
}
