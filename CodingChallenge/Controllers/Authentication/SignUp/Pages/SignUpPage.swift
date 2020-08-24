//
//  SignUpPage.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

class SignUpPage: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    let stackView: UIStackView = {
        $0.spacing = 25
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let titleLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textColor = .systemBlue
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let detailLabel: UILabel = {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let bottomLabel: ActionLabel = {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.textColor = .link
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Already have an account?"
        return $0
    }(ActionLabel())
    
    let button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.systemBlue
        
        $0.layer.cornerRadius = 8
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 110, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 30, right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 30, height: 0)
        
        view.addSubview(bottomLabel)
        bottomLabel.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 25)
        bottomLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        bottomLabel.action { _ in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    func setButtonTitle(string: String) {
        let x = NSAttributedString(string: string, attributes: [.foregroundColor: UIColor.systemBackground, .font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        button.setAttributedTitle(x, for: .normal)
    }
    
    @objc func didTapButton(_ sender: UIButton?) {
        
    }
}
