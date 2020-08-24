//
//  LoginTextField.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoginTextField: UIStackView {
    
    enum TextFieldType {
        case email, password, country, none
    }
    
    weak var delegate: LoginTextFieldDelegate?
    
    // Views
    let textField = PaddedTextField()
    
    private let label: ActionLabel = {
        $0.isHidden = true
        $0.font = UIFont.preferredFont(forTextStyle: .caption2)
        $0.textColor = UIColor.systemOrange
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        return $0
    }(ActionLabel())
    
    private let separater = SeparaterView()
    
    lazy var rightButton: UIButton = {
        let size: CGFloat = 25.0
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(size/2.0), bottom: 0, right: 0)
        $0.frame = CGRect(x: self.frame.size.width - size, y: 0.0, width: size, height: size)
        $0.addTarget(self, action: #selector(didTapRightButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    
    
    // Variables
    private let textFieldType: TextFieldType
    
    
    private(set) var labelText: String? {
        didSet {
            guard oldValue != labelText else { return }
            label.text = labelText
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 7, initialSpringVelocity: 7, options: .beginFromCurrentState) {
                self.label.isHidden = self.labelText == nil
            }completion: { _ in
            }
        }
    }
    
    
    
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
}

// Setup
extension LoginTextField {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        spacing = 8
        
        switch textFieldType {
        case .email:
            textField.textContentType = .emailAddress
            textField.placeholder = "email address"
            textField.keyboardType = .emailAddress
        case .password:
            textField.isSecureTextEntry = true
            textField.textContentType = .password
            textField.placeholder = "password"
        case .country:
            textField.placeholder = "country"
            textField.textContentType = .countryName
            setCurrentCountry()
            textField.rightView = rightButton
            textField.rightViewMode = .always
        case .none:
            break
        }
        
        addArrangedSubview(label)
        addArrangedSubview(textField)
        addArrangedSubview(separater)
        textField.delegate = self
    }
}

// TextField Delegate

extension LoginTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        labelText = nil
        self.textField.rightImageName = nil
        delegate?.loginTextField(textFieldDidBeginEditing: self, type: textFieldType)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textFieldType {
        case .email:
            let isValid = textField.text?.isValidEmail() == true
            self.textField.isValid = isValid
            labelText = isValid ? nil : "invalid email"
        case .password:
            let isValid = textField.text?.isValidPassword() == true
            self.textField.isValid = isValid
            labelText = isValid ? nil : "password is too short"
        default:
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
        self.textField.rightImageName = string + ".circle.fill"
        return string != " "
    }

}

// Methods
extension LoginTextField {
    
    @objc private func didTapRightButton(_ sender: UIButton?) {
        let alert = UIAlertController(style: .actionSheet)
        alert.addLocalePicker() { info in
            guard let info = info else { return }
            self.textField.text = info.country
            let flag = info.flag?.imageWithSize(size: CGSize(width: 30, height: 30), roundedRadius: 15)
            self.rightButton.setImage(flag, for: .normal)
        }
        
        alert.show()
        
    }
    
    private func setFlag() {
        if textFieldType == .country, let countryName = textField.text, let regionCode = Locale.current.countryCode(from: countryName) {
            let flag = UIImage(named: "Countries.bundle/Images/\(regionCode.uppercased())", in: Bundle.main, compatibleWith: nil)?.imageWithSize(size: CGSize(width: 30, height: 30), roundedRadius: 15)
            rightButton.setImage(flag, for: .normal)
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
        textField.rightImageName = nil
        labelText = nil
        textField.text = nil
        setCurrentCountry()
    }
}
