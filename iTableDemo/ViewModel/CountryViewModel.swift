//
//  CountryViewModel.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation

protocol CountryListViewModelProtocol:class {
    func refreshModelList()
}

class CountryListViewModel:NSObject {
    
    private var countryViewModels:[CountryModel] = [CountryModel]()
    
    private var token :NSKeyValueObservation?
    private var webservice:WebService
    weak var delegate:CountryListViewModelProtocol?
    
    init(webservice: WebService) {
        self.webservice = webservice
        super.init()
        getCountryInfo()
    }
    
    
    /// Function to get Country info
    func getList() -> [CountryInfo]  {
        return self.countryViewModels.first?.rows ?? []
    }
    
    /// Function to get Country title
    func getTitle() -> String {
        return self.countryViewModels.first?.title ?? ""
    }
    
    /// Function to get country info from swbservice
    func getCountryInfo() {
        webservice.loadSources { (countryViewModel) in
            self.countryViewModels = [countryViewModel]
            self.delegate?.refreshModelList()
        }
    }
    
}
