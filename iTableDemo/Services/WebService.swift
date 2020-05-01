//
//  WebService.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

protocol WebServiceProtocol {
    func loadSources(completion :@escaping (CountryModel) -> Void)
}

class WebService: WebServiceProtocol {
    
    private let sourcesURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
    /// Function to call get country webservice and map to CountryModel
    /// - Parameter completion: Returning  CountryModel
    func loadSources(completion :@escaping (CountryModel) -> Void) {
        
        Alamofire.request(sourcesURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            if response.response?.statusCode == 200 {

                let respData = response.result.value?.data(using: .utf8)

                do {
                    if let jsonObj = try JSONSerialization.jsonObject(with: respData!, options: .allowFragments) as? [String: Any] {
                       let list =  CountryModel.init(dictionary: jsonObj)
                        completion(list!)
                    } else {
                        print("Error in Json conversion")
                    }
                } catch let error as NSError {
                    print(error)
                }

            }
        }
    }
}
