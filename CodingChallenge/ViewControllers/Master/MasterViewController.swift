//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    lazy var manager = MasterManager()
    
    let tableView: UITableView = {
        $0.estimatedRowHeight = 70
        $0.rowHeight = UITableView.automaticDimension
        $0.register(MasterTableViewCell.self, forCellReuseIdentifier: MasterTableViewCell.reuseIdentifier)
        $0.tableFooterView = UIView()
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
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

extension MasterViewController {
    
    private func setup() {
        title = "Master"
    }
    
    private func setupManager() {
        manager.delegate = self
        tableView.dataSource = manager
        tableView.delegate = manager
    }
}

extension MasterViewController: MasterManagerDelegate {
    
    func masterManagerDelegate(didSelectUser user: User) {
        let x = UserViewController()
        x.user = user
        navigationController?.pushViewController(x, animated: true)
    }
    
    func notesDidChange() {
        print("data change")
    }
}
