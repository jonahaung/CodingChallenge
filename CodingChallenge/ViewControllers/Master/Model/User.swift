//
//  User.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 22/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    // address
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let lat: String
    let lng: String
    let phone: String
    let website: String
    // company
    let companyName: String
    let catchPhrase: String
    let bs: String
    
    private enum CodingKeys : String, CodingKey {
        
        case id, name, username, email, address, phone, website, company
        
        enum Address: String, CodingKey {
            case street, suite, city, zipcode, geo
            
            enum Geo: String, CodingKey {
                case lat, lng
            }
        }
        
        enum Company: String, CodingKey {
            case name, catchPhrase, bs
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        
        // address
        let addressContainer = try container.nestedContainer(keyedBy: CodingKeys.Address.self, forKey: .address)
        
        street = try addressContainer.decode(String.self, forKey: .street)
        suite = try addressContainer.decode(String.self, forKey: .suite)
        city = try addressContainer.decode(String.self, forKey: .city)
        zipcode = try addressContainer.decode(String.self, forKey: .zipcode)
        
        let addressGeoContainer = try addressContainer.nestedContainer(keyedBy: CodingKeys.Address.Geo.self, forKey: .geo)
        lat = try addressGeoContainer.decode(String.self, forKey: .lat)
        lng = try addressGeoContainer.decode(String.self, forKey: .lng)
        
        phone = try container.decode(String.self, forKey: .phone)
        website = try container.decode(String.self, forKey: .website)
        
        // company
        let companyContainer = try container.nestedContainer(keyedBy: CodingKeys.Company.self, forKey: .company)
        companyName = try companyContainer.decode(String.self, forKey: .name)
        catchPhrase = try companyContainer.decode(String.self, forKey: .catchPhrase)
        bs = try companyContainer.decode(String.self, forKey: .bs)
    }
}
