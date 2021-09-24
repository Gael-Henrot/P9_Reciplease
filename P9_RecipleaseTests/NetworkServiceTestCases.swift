//
//  NetworkServiceTestCases.swift
//  P9_RecipleaseTests
//
//  Created by Gaël HENROT on 20/09/2021.
//

import XCTest
import Alamofire
@testable import P9_Reciplease

class NetworkServiceTestCases: XCTestCase {
    
    var networkService = NetworkService()
    
    override func setUp() {
        MockURLProtocol.registerClass(MockURLProtocol.self)
    }
    
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://api.edamam.com/api/recipes/v2")!
    let ingredientList = ["Tomato,","Potato,"]
    
//    override class func setUp() {
//        super.setUp()
//        let configuration = URLSessionConfiguration.af.default
//        configuration.protocolClasses = [MockURLProtocol.self]
//        let sessionManager = Session(configuration: configuration)
//    }
    
    func testFetchRecipesSuccess() {
        MockURLProtocol.fakeResponse = [
            apiURL:
                (FakeResponse.recipesCorrectData,
                 HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                 nil)
        ]
        URLProtocol.registerClass(MockURLProtocol.self)
        networkService.fetchRecipes(with: ingredientList) { result in
        }
    }
}
