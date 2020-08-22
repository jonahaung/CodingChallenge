//
//  MasterManager.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 21/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

protocol MasterManagerDelegate: class {
    var tableView: UITableView { get }
    func masterManagerDelegate(didSelectUser user: User)
}


final class MasterManager: NSObject {
    
    private var users = [User]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    weak var delegate: MasterManagerDelegate?
    
    var tableView: UITableView? {
        return delegate?.tableView
    }
    
    override init() {
        super.init()
        getData()
    }
}

extension MasterManager {
    
    private func getData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                print(data)
                do {
                    let users = try JSONDecoder().decode(Array<User>.self, from: data   )
                    DispatchQueue.main.async {
                        self?.users = users
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

extension MasterManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MasterTableViewCell.reuseIdentifier, for: indexPath) as? MasterTableViewCell else { fatalError() }
        cell.configure(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Users : \(users.count)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        delegate?.masterManagerDelegate(didSelectUser: user)
    }
}
