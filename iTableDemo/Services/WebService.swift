//
//  WebService.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String:Any]

class WebService {
    
    private let sourcesURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
    func loadSources(completion :@escaping (CountryModel) -> ()) {
        
        Alamofire.request(sourcesURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            if response.response?.statusCode == 200 {

                let respData = response.result.value?.data(using: .utf8)

                do {
                    if let jsonObj = try JSONSerialization.jsonObject(with: respData!, options : .allowFragments) as? [String:Any]
                    {
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
