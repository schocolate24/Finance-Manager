//
//  CurrencyConvert.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/29.
//

import Foundation
import Alamofire
//copied from a tutorial

struct CurrencyConvert: Codable {
var success: Bool
var base: String
var date: String
var rates = [String: Double]() // an empty dictionary
}

// here we request the api and see if we successfully got the result or not
    func apiRequest(url: String, completion: @escaping (CurrencyConvert) -> ()) {
    Session.default.request(url).responseDecodable(of: CurrencyConvert.self) { response in
        switch response.result{
        case .success(let currencies):
            print(currencies)
            completion(currencies)
        case .failure(let error):
            print(error)
        }
    }
}
