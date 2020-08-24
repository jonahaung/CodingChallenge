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
    
    func showAlert(title: String?, message: String?, buttonText: String, from vc: UIViewController?, completion: @escaping (Bool) -> Void) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        let x = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: buttonText, style: .default) { _ in
            completion(true)
        }
        x.addAction(action)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        x.addAction(cancel)
        if let vc = vc {
            vc.present(x, animated: true)
        }else {
            x.show()
        }
    }
}
