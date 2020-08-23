//
//  UsersManagerDelegate.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

protocol UsersManagerDelegate: class {
    var tableView: UITableView { get }
    func usersManagerDelegate(didSelectUser user: User)
    func usersManagerDelegate(didReloadData users: [User])
}
