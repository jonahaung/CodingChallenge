//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class UsersViewController: UIViewController {

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    internal let tableView: UITableView = {
        $0.estimatedRowHeight = 70
        $0.rowHeight = UITableView.automaticDimension
        $0.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    private let footerLabel: UILabel = {
        $0.textColor = .systemOrange
        return $0
    }(UILabel())
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
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapLeftBarButtonItem))
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let logout = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(didTapLogout))
        navigationController?.setToolbarHidden(false, animated: true)
        toolbarItems = [UIBarButtonItem(customView: footerLabel), UIBarButtonItem.flexible, logout]
        
        
    }
    
    private func setupManager() {
        manager.delegate = self
        tableView.dataSource = manager
        tableView.delegate = manager
    }
    
    @objc private func didTapLogout() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if let nav = navigationController as? NavigationController {
            loading(true) {
                loading(false)
                nav.isLoggedIn.toggle()
            }
        }
    }
    
    @objc private func didTapLeftBarButtonItem() {
        manager.reset()
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
}

// Manager Delegate
extension UsersViewController: UsersManagerDelegate {
    
    func usersManagerDelegate(didReloadData users: [User]) {
        let count = users.count
        footerLabel.text = count.description
        footerLabel.sizeToFit()
        if count > 50 {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    
    func usersManagerDelegate(didSelectUser user: User) {
        let x = UserViewController()
        x.user = user
        navigationController?.pushViewController(x, animated: true)
    }

}
