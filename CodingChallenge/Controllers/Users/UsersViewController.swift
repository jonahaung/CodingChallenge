//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class UsersViewController: UIViewController {
    
    internal let tableView: UITableView = {
        $0.estimatedRowHeight = 70
        $0.rowHeight = UITableView.automaticDimension
        $0.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
        $0.tableFooterView = UIView()
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
    private lazy var manager = UsersManager()
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Appearance
        setup()
        setupManager()
    }
}

extension UsersViewController {
    
    private func setup() {
        title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(didTapLogout))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapLeftBarButtonItem))
    }
    
    private func setupManager() {
        manager.delegate = self
        tableView.dataSource = manager
        tableView.delegate = manager
    }
    
    @objc private func didTapLogout() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if let nav = navigationController as? NavigationController {
            nav.isLoggedIn.toggle()
        }
    }
    
    @objc private func didTapLeftBarButtonItem() {
        
    }
}

// Manager Delegate
extension UsersViewController: UsersManagerDelegate {
    
    func usersManagerDelegate(didReloadData users: [User]) {
        title = users.count.description
    }
    
    
    func usersManagerDelegate(didSelectUser user: User) {
        let x = UserViewController()
        x.user = user
        navigationController?.pushViewController(x, animated: true)
    }

}
