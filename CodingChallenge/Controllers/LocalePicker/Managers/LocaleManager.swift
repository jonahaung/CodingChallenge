//
//  LocaleStore.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//


import Foundation

struct LocaleManager {
    
    enum GroupedByAlphabetsFetchResults {
        case success(response: [String: [LocaleInfo]])
        case error(error: (title: String?, message: String?))
    }
    
    enum FetchResults {
        case success(response: [LocaleInfo])
        case error(error: (title: String?, message: String?))
    }
    
    static func getInfo(completionHandler: @escaping (FetchResults) -> ()) {
        let bundle = Bundle(for: LocalePickerViewController.self)
        let path = "Countries.bundle/Data/CountryCodes"
        
        guard let jsonPath = bundle.path(forResource: path, ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            let error: (title: String?, message: String?) = (title: "ContryCodes Error", message: "No ContryCodes Bundle Access")
            return completionHandler(FetchResults.error(error: error))
        }
        
        if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)) as? Array<Any> {
            var result: [LocaleInfo] = []
            for jsonObject in jsonObjects {
                guard let countryObj = jsonObject as? Dictionary<String, Any> else { continue }
                guard let country = countryObj["name"] as? String,
                      let code = countryObj["code"] as? String,
                      let phoneCode = countryObj["dial_code"] as? String else {
                    continue
                }
                let new = LocaleInfo(country: country, code: code, phoneCode: phoneCode)
                result.append(new)
            }
            return completionHandler(FetchResults.success(response: result))
        }
        
        let error: (title: String?, message: String?) = (title: "JSON Error", message: "Couldn't parse json to Info")
        return completionHandler(FetchResults.error(error: error))
    }
    
    static func fetch(completionHandler: @escaping (GroupedByAlphabetsFetchResults) -> ()) {
        LocaleManager.getInfo { result in
            switch result {
            case .success(let info):
                
                var data = [String: [LocaleInfo]]()
                
                info.forEach {
                    let country = $0.country
                    let index = String(country[country.startIndex])
                    var value = data[index] ?? [LocaleInfo]()
                    value.append($0)
                    data[index] = value
                }
                
                data.forEach { key, value in
                    data[key] = value.sorted(by: { lhs, rhs in
                        return lhs.country < rhs.country
                    })
                }
                completionHandler(GroupedByAlphabetsFetchResults.success(response: data))
                
            case .error(let error):
                completionHandler(GroupedByAlphabetsFetchResults.error(error: error))
            }
        }
    }
}
