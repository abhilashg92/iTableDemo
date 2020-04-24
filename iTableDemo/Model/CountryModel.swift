//
//  CountryModel.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation


struct CountryModel {
    var title: String?
    var rows = [CountryInfo]()
    // var imageUrl:String
    
    init?(dictionary :JSONDictionary) {
        
        guard let title = dictionary["title"] as? String,
            let list = dictionary["rows"] as? [[String:Any]] else {
                return nil
        }
        
        for i in list {
            if let info = CountryInfo(dict: i) {
                rows.append(info)
            }
        }
        self.title = title
        //        self.rows = list
    }
    
}

struct CountryInfo {
    var header: String?
    var desc:String?
    var imgUrl:String?
    
    init?(dict: JSONDictionary) {
        
        guard let header = dict["title"] as? String else {
            return nil
        }
        
        if  let desc = dict["description"] as? String {
            self.desc = desc
        }
        
        if let imageUrl = dict["imageHref"] as? String {
            self.imgUrl = imageUrl
        }
        self.header = header
    }
    
}
