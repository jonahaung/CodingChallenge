//
//  UITextField+Extensions.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

extension UITextField {
    
    func left(image: UIImage?, color: UIColor = .secondaryLabel) {
        if let image = image {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 25, height: 25))
            imageView.contentMode = .center
            
            imageView.image = image
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
    
    func right(image: UIImage?, color: UIColor = .black) {
        if let image = image {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }
}

public extension UITextField {
    
    func setPlaceHolderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[.foregroundColor: color])
    }
    
    func placeholder(text value: String, color: UIColor = .red) {
        self.attributedPlaceholder = NSAttributedString(string: value, attributes: [ .foregroundColor : color])
    }
}
