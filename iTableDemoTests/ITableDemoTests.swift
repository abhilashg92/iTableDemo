//
//  iTableDemoTests.swift
//  iTableDemoTests
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import XCTest
@testable import iTableDemo

let deaversDesc = "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony"

let deaversUrl = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"

let transportationDesc = "It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal"

let transportationUrl = "http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg"

class ITableDemoTests: XCTestCase, CountryListViewModelProtocol {
    
    var expectation: XCTestExpectation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func refreshFailure() {
        //
    }
    
    func refreshModelList() {
        //
        expectation.fulfill()
    }
    
    func testNavigationTitle() {
        let webService = WebServiceMock()
        let countryVM = CountryListViewModel(webservice: webService)
        XCTAssertEqual(countryVM.getTitle(), "Canada")
        
    }
    
    func testRefresCountryInfoList() {
        let webService = WebServiceMock()
        let countryVM = CountryListViewModel(webservice: webService)
        countryVM.delegate = self
        expectation = expectation(description: "RefreshModelList")
        countryVM.getCountryInfo()
        
        waitForExpectations(timeout: 3) { error in
            if error != nil {
                XCTFail("waitForExpectationsWithTimeout errored: \(error!)")
            } else {
                XCTAssertTrue(true, "Pass")
            }
            
        }
    }
    
    func testNumberOFInfoItems() {
        let webService = WebServiceMock()
        let countryVM = CountryListViewModel(webservice: webService)
        XCTAssertEqual(countryVM.getList().count, 2)
    }
    
    func testInfoCardDescripton() {
        let webService = WebServiceMock()
        let countryVM = CountryListViewModel(webservice: webService)
        XCTAssertEqual(countryVM.getList().first?.desc, deaversDesc)
        XCTAssertEqual(countryVM.getList().last?.desc, transportationDesc)
    }
    
    func testInfoCardTitle() {
        let webService = WebServiceMock()
        let countryVM = CountryListViewModel(webservice: webService)
        XCTAssertEqual(countryVM.getList().first?.header, "Beavers")
        XCTAssertEqual(countryVM.getList().last?.header, "Transportation")
    }
    
    func testInfoCardImageUrl() {
        let webService = WebServiceMock()
        let countryVM = CountryListViewModel(webservice: webService)
        XCTAssertEqual(countryVM.getList().first?.imgUrl, deaversUrl)
        XCTAssertEqual(countryVM.getList().last?.imgUrl, transportationUrl)
    }
}

class WebServiceMock: WebServiceProtocol {
    func loadSources(completion: @escaping (CountryModel) -> Void) {
        let beaversDict: [String: Any] =
                        ["title": "Beavers",
                           "imageHref": deaversUrl,
                           "description": deaversDesc]
        
        let transportationDict: [String: Any] = ["title": "Transportation",
                           "imageHref": "http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg",
                           "description": transportationDesc]

        let dict: [String: Any]  = ["rows": [beaversDict, transportationDict],
                    "title": "Canada"]
        
        let countryModel = CountryModel(dictionary: dict)
        
        completion(countryModel!)
        
    }
}
