//
//  AlertPresenting.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

protocol AlertPresenting {
    
}

extension AlertPresenting {
    func showAlert(title: String?, message: String?) {
        let x = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        x.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        x.show()
    }
}
