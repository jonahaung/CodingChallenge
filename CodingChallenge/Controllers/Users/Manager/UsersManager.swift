//
//  MasterManager.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class UsersManager: NSObject {
    
    private var users = [User]()
    
    weak var delegate: UsersManagerDelegate?
    private var isLoadingList = false
    var tableView: UITableView? {
        return delegate?.tableView
    }
    
    override init() {
        super.init()
        getData()
    }
}

// Fetch Users From API
extension UsersManager {
    
    func getData(){
        isLoadingList = true
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(Array<User>.self, from: data)
                DispatchQueue.main.async {
                    guard let self = self else { return }
//                    self.tableView?.beginUpdates()
                    users.forEach {
                        self.users.append($0)
                        let row = self.users.count == 0 ? 0 : self.users.count - 1
                        let indexPath = IndexPath(row: row, section: 0)
                        
                        self.tableView?.insertRows(at: [indexPath], with: .automatic)
                    }
//                    self.tableView?.endUpdates()
                    self.isLoadingList = false
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

// TableView Datasource & Delegate

extension UsersManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier, for: indexPath) as? UsersTableViewCell else { fatalError() }
        cell.configure(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Total : \(users.count) users"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        delegate?.usersManagerDelegate(didSelectUser: user)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height && !isLoadingList {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            getData()
        }
    }
}
