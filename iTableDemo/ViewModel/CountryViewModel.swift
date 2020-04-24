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
        populateSources()
    }
    
    func getList() -> [CountryInfo]  {
        return self.countryViewModels.first?.rows ?? []
    }
    
    func getTitle() -> String {
        return self.countryViewModels.first?.title ?? ""
    }
    
    
    func populateSources() {
        webservice.loadSources { (countryViewModel) in
            self.countryViewModels = [countryViewModel]
            self.delegate?.refreshModelList()
        }
    }
    
}
