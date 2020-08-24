//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class UsersViewController: UIViewController, AlertPresenting {

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    internal let tableView: UITableView = {
        let imageView = UIImageView(image: UIImage(named: "welcome"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemRed
        $0.tableHeaderView = imageView
        $0.bounces = true
        $0.estimatedRowHeight = 70
        $0.rowHeight = UITableView.automaticDimension
        $0.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    private let footerLabel: UILabel = {
        $0.textColor = .secondaryLabel
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let logout = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(didTapLogout))
        
        toolbarItems = [UIBarButtonItem(customView: footerLabel), UIBarButtonItem.flexible, logout]
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.contentSize.width, height: 120)
    }

}

extension UsersViewController {
    
    private func setup() {
        title = "Users List"
       
        let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetData))
        refreshButtonItem.isEnabled = false
        navigationItem.rightBarButtonItems = [editButtonItem, refreshButtonItem]
        
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = AuthManager.shared.currentUser?.name
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    private func setupManager() {
        manager.delegate = self
        tableView.dataSource = manager
        tableView.delegate = manager
    }
    
    @objc private func didTapLogout() {
        showAlert(title: "Are you sure you want to log out?", message: nil, buttonText: "Continue Log Out", from: nil) { x in
            if x == true {
                AuthManager.shared.signOut()
            }
        }
    }
    
    @objc private func resetData() {
        manager.reset()
        navigationItem.rightBarButtonItems?.last?.isEnabled = true
    }
}

// Manager Delegate
extension UsersViewController: UsersManagerDelegate {
    
    func usersManagerDelegate(didReloadData users: [User]) {
        let count = users.count
        footerLabel.text = count.description
        footerLabel.sizeToFit()
        if count > 50 {
            navigationItem.rightBarButtonItems?.last?.isEnabled = true
        }
    }
    
    
    func usersManagerDelegate(didSelectUser user: User) {
        let x = UserViewController()
        x.user = user
        navigationController?.pushViewController(x, animated: true)
    }

}
