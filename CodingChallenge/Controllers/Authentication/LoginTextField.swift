//
//  LoginTextField.swift
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

final class LoginTextField: UIStackView {
    
    enum TextFieldType {
        case username, password, country
    }
    
    weak var delegate: LoginTextFieldDelegate?
    
    private let textField: UITextField = {
        $0.borderStyle = .none
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.adjustsFontSizeToFitWidth = true
        $0.autocapitalizationType = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return $0
    }(UITextField())
    
    private let label: UILabel = {
        $0.isHidden = true
        $0.font = UIFont.preferredFont(forTextStyle: .caption2)
        $0.heightAnchor.constraint(equalToConstant: 12).isActive = true
        $0.textColor = UIColor.systemOrange
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let separater: UIView = {
        $0.backgroundColor = UIColor.separator
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return $0
    }(UIView())
    
    lazy var rightButton: UIButton = {
        let size: CGFloat = 25.0
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(size/2.0), bottom: 0, right: 0)
        $0.frame = CGRect(x: self.frame.size.width - size, y: 0.0, width: size, height: size)
        $0.addTarget(self, action: #selector(didTapRightButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    private let iconView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25)))
    
    private var iconName: String? {
        didSet {
            guard oldValue != iconName else { return }
            guard let iconName = iconName else {
                iconView.image = nil
                iconView.tintColor = nil
                return
            }
            self.iconView.image = UIImage(systemName: iconName)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            animateIcon()
            
        }
    }
    var labelText: String? {
        didSet {
            guard oldValue != labelText else { return }
            label.text = labelText
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 7, initialSpringVelocity: 7, options: .beginFromCurrentState) {
                self.label.isHidden = self.labelText == nil
            }completion: { _ in
            }
        }
    }
    
    private let textFieldType: TextFieldType
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    
    
    
    init(_ _textFieldType: TextFieldType) {
        textFieldType = _textFieldType
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupRightIconView() {
        let rightIconView = UIView(frame: CGRect(x: textField.frame.size.width - 30, y: 0, width: 30, height: 25))
        rightIconView.addSubview(iconView)
        textField.rightView = rightIconView
        textField.rightViewMode = .always
    }
    
   
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        
        switch textFieldType {
        case .username:
            textField.textContentType = .username
            textField.placeholder = "username/email"
            setupRightIconView()
        case .password:
            textField.isSecureTextEntry = true
            textField.textContentType = .password
            textField.placeholder = "password"
            setupRightIconView()
        case .country:
            textField.textContentType = .countryName
            textField.returnKeyType = .done
            
            setCurrentCountry()
            textField.rightView = rightButton
            textField.rightViewMode = .always
        }
        
        addArrangedSubview(label)
        addArrangedSubview(textField)
        addArrangedSubview(separater)
        textField.delegate = self
    }
    
    
}

extension LoginTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        labelText = nil
        delegate?.loginTextField(textFieldDidBeginEditing: self, type: textFieldType)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.isEmpty == true || textField.text == nil {
            labelText = "this field shouldn't be empty"
        } else {
            labelText = nil
        }
        switch textFieldType {
        case .username:
            if textField.hasText == true {
                iconName = "checkmark.shield.fill"
                iconView.tintColor = .systemGreen
            } else {
                iconName = "exclamationmark.circle.fill"
                iconView.tintColor = .systemRed
            }
        case .password:
            break
        case .country:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.loginTextField(textFieldShouldReturn: self, type: textFieldType)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textFieldType == .country {
            
            didTapRightButton(nil)
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textFieldType == .password {
            iconName = string + ".circle.fill"
        }
        
        return string != " "
    }

}

extension LoginTextField {
    
    @objc private func didTapRightButton(_ sender: UIButton?) {
        let alert = UIAlertController(style: .actionSheet)
        alert.addLocalePicker() { info in
            guard let info = info else { return }
            self.textField.text = info.country
            let flag = info.flag?.imageWithSize(size: CGSize(width: 30, height: 24), roundedRadius: 5)
            self.rightButton.setImage(flag, for: .normal)
        }
        alert.addAction(title: "Cancel", style: .cancel)
        alert.show()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func setFlag() {
        if textFieldType == .country, let countryName = textField.text, let regionCode = Locale.current.countryCode(from: countryName) {
            let flag = UIImage(named: "Countries.bundle/Images/\(regionCode.uppercased())", in: Bundle.main, compatibleWith: nil)?.imageWithSize(size: CGSize(width: 30, height: 24), roundedRadius: 5)
            rightButton.setImage(flag, for: .normal)
        }
    }
    
    private func animateIcon() {
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 7, initialSpringVelocity: 7, options: .beginFromCurrentState) {
            self.iconView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { _ in
            
            UIView.animate(withDuration: 0.2) {
                self.iconView.transform = CGAffineTransform(rotationAngle: 90)
            } completion: { _ in
                self.iconView.transform = .identity
            }
        }
    }
    
    fileprivate func setCurrentCountry() {
        guard textFieldType == .country else { return }
        let locale = Locale.current
        if let regionCode = locale.regionCode {
            textField.text = locale.localizedString(forRegionCode: regionCode)
        }
        setFlag()
    }
    
    
    func reset() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        iconName = nil
        labelText = nil
        textField.text = nil
        setCurrentCountry()
    }
}
