//
//  Extensions.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit
import MapKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0, bottom: NSLayoutYAxisAnchor? = nil, paddingBottom: CGFloat = 0, left: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0, right: NSLayoutXAxisAnchor? = nil, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
extension Locale {
    
    func countryCode(from countryName: String) -> String? {
        return NSLocale.isoCountryCodes.first { (code) -> Bool in
            let name = self.localizedString(forRegionCode: code)
            return name == countryName
        }
    }
    
}

extension UITextField {
    func setIcon(_ image: UIImage?, tintColor: UIColor?) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = tintColor
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: frame.size.width - 30, y: 0, width: 30, height: 20))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 7, initialSpringVelocity: 7, options: .beginFromCurrentState) {
            self.rightView?.subviews.first?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { _ in
            self.rightView?.subviews.first?.transform = .identity
        }
    }
}
