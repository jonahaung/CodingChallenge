//
//  SeparaterView.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class SeparaterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.separator
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
