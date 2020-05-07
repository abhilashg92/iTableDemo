//
//  CountryViewModel.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation
import Alamofire

protocol CountryListViewModelProtocol: class {
    func refreshModelList()
    func refreshFailure()
}

class CountryListViewModel: NSObject {

    private var countryViewModels: [CountryModel] = [CountryModel]()
    private var webservice: WebServiceProtocol!
    weak var delegate: CountryListViewModelProtocol?

    init(webservice: WebServiceProtocol) {
        self.webservice = webservice
        super.init()
        getCountryInfo()
    }

    /// Function to get Country info
    func getList() -> [CountryInfo] {
        return self.countryViewModels.first?.rows ?? []
    }

    /// Function to get Country title
    func getTitle() -> String {
        return self.countryViewModels.first?.title ?? ""
    }

    /// Function to get country info from swbservice
    func getCountryInfo() {
        if NetworkReachabilityManager()?.isReachable ?? false {
            webservice.loadSources { (countryViewModel) in
                self.countryViewModels = [countryViewModel]
                self.delegate?.refreshModelList()
            }
        } else {
            self.delegate?.refreshFailure()
        }
    }

}
