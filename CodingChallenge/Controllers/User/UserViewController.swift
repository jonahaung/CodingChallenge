//
//  UserViewController.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 22/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit
import MapKit

final class UserViewController: UIViewController {
    
    var user: User?
    
    let mapView: MKMapView = {
        $0.layer.borderColor = UIColor.systemBackground.cgColor
        $0.layer.borderWidth = 1
        $0.mapType = .standard
        return $0
    }(MKMapView())
    
    let tableView: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addMappin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocation()
    }
    
    override func viewWillLayoutSubviews() {
        mapView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height/2)
        super.viewWillLayoutSubviews()
    }
    deinit {
        print("Deinit: UserViewController")
    }
}

// Map
extension UserViewController {
    
    private func addMappin() {
        guard let coordinate = user?.getLocation() else { return }
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = user?.city
        pin.subtitle = user?.city
        mapView.addAnnotation(pin)
    }
    
    @objc private func setLocation() {
        guard let coordinate = user?.getLocation() else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

// setup
extension UserViewController {
    
    private func setup(){
        title = user?.name
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(setLocation))
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableHeaderView = mapView
        
        navigationController?.setToolbarHidden(true, animated: true)
    }
}

// Table View
extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier) as? UserTableViewCell else {
            fatalError()
        }
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = user?.username
            cell.detailTextLabel?.text = "username"
            cell.imageView?.image = UIImage(systemName: "person.crop.square")
        case 1:
            cell.textLabel?.text = user?.email
            cell.detailTextLabel?.text = "email"
            cell.imageView?.image = UIImage(systemName: "at")
        case 2:
            
            cell.textLabel?.text = user?.city
            cell.detailTextLabel?.text = "city"
            cell.imageView?.image = UIImage(systemName: "house")
        case 3:
            cell.textLabel?.text = user?.phone
            cell.detailTextLabel?.text = "phone"
            cell.imageView?.image = UIImage(systemName: "phone")
        case 4:
            cell.textLabel?.text = user?.website
            cell.detailTextLabel?.text = "website"
            cell.imageView?.image = UIImage(systemName: "link")
        case 5:
            cell.textLabel?.text = user?.companyName
            cell.detailTextLabel?.text = "company"
            cell.imageView?.image = UIImage(systemName: "building")
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let suite = user?.suite, let street = user?.street, let city = user?.city, let zip = user?.zipcode {
            return suite + ". " + street + ". " + city + ". " + zip
        }
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "User ID: " + (user?.id.description ?? "")
    }
    
}

