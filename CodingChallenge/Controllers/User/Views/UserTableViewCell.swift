//
//  UserTableViewCell.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "UserTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: UserTableViewCell.reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        imageView?.tintColor = UIColor.systemOrange
        selectionStyle = .none
    }
}
