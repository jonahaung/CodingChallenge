//
//  PaddedTextField.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override var leftView: UIView? {
        didSet {
            if let x = leftView {
                padding.left += x.width
            } else {
                padding.left = 8
            }
        }
    }
    
    let rightImageView: UIImageView = {
        $0.contentMode = .center
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25)))
    
    var rightImageName: String? {
        didSet {
            guard oldValue != rightImageName else { return }
            guard let iconName = rightImageName else {
                rightImageView.image = nil
                rightImageView.tintColor = nil
                return
            }
            rightImageView.image = UIImage(systemName: iconName)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            animateIcon()
        }
    }
    
    var isValid = false {
        didSet {
            rightImageName = isValid ? "checkmark.circle.fill" : "exclamationmark.circle.fill"
            rightImageView.tintColor = isValid ? UIColor.systemGreen : .systemRed
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .none
        font = UIFont.preferredFont(forTextStyle: .title3)
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        returnKeyType = .go
    
        rightView = rightImageView
        rightViewMode = .always
        
        setPlaceHolderTextColor(.quaternaryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func animateIcon() {
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 7, initialSpringVelocity: 7, options: .beginFromCurrentState) {
            self.rightImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        } completion: { _ in
            
            UIView.animate(withDuration: 0.2) {
                self.rightImageView.transform = CGAffineTransform(rotationAngle: 90)
            } completion: { _ in
                self.rightImageView.transform = .identity
            }
        }
    }
}
