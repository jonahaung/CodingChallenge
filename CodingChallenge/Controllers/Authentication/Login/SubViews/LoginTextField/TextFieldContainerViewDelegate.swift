//
//  LoginTextFieldDelegate.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

protocol TextFieldContainerViewDelegate: class {
    func textFieldContainerViewDelegate(textFieldDidBeginEditing textField: TextFieldContainerView,  type: TextFieldContainerView.TextFieldType)
    func textFieldContainerViewDelegate(textFieldShouldReturn textField: TextFieldContainerView, type: TextFieldContainerView.TextFieldType)
}
