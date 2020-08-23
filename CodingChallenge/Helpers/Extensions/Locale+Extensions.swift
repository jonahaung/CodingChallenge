//
//  Locale+Extensions.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import Foundation

extension Locale {
    
    func countryCode(from countryName: String) -> String? {
        return NSLocale.isoCountryCodes.first { (code) -> Bool in
            let name = self.localizedString(forRegionCode: code)
            return name == countryName
        }
    }
    
}
