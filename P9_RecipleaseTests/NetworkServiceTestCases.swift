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
    
    override func setUp() {
//        MockURLProtocol.registerClass(MockURLProtocol.self)
    }
    func testFetchRecipesSuccessCase() {
        let expectation = self.expectation(description: "Success")
        let client = MockClient(fakeResponses: .success)
        let recipeService = RecipeProvider(client: client)
        
        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertNotNil(try? result.get())
            XCTAssertEqual(FakeRecipeProviderResponses.correctRecipeDataArray, try! result.get())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSecondFetchRecipesSuccessCase() {
        let expectation = self.expectation(description: "Success")
        let client = MockClient(fakeResponses: .success)
        let recipeService = RecipeProvider(client: client)
        
        recipeService.fetchRecipes(firstcall: false, loading: true) { result in
            XCTAssertNotNil(try? result.get())
            XCTAssertEqual(FakeRecipeProviderResponses.correctRecipeDataArray, try! result.get())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchRecipesWrongStatusFailureCase() {
        let expectation = self.expectation(description: "Failure")
        let client = MockClient(fakeResponses: .failureWithWrongStatusCode)
        let recipeService = RecipeProvider(client: client)

        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertEqual(result, .failure(.noRecipeFound))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFetchRecipesRequestErrorFailureCase() {
        let expectation = self.expectation(description: "Failure")
        let client = MockClient(fakeResponses: .failureWithRequestError)
        let recipeService = RecipeProvider(client: client)

        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertEqual(result, .failure(.noRecipeFound))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFetchRecipesNoDataFailureCase() {
        let expectation = self.expectation(description: "Failure")
        let client = MockClient(fakeResponses: .failureWithoutData)
        let recipeService = RecipeProvider(client: client)

        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertEqual(result, .failure(.noRecipeFound))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFetchRecipesDecodingFailureCase() {
        let expectation = self.expectation(description: "Failure")
        let client = MockClient(fakeResponses: .failureWithDecodingIssue)
        let recipeService = RecipeProvider(client: client)

        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertEqual(result, .failure(.noRecipeFound))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFetchRecipesNoRecipeListFailureCase() {
        let expectation = self.expectation(description: "Failure")
        let client = MockClient(fakeResponses: .successWithEmptyRecipeList)
        let recipeService = RecipeProvider(client: client)

        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertEqual(result, .failure(.noRecipeFound))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchRecipesNoRecipeinRecipeListFailureCase() {
        let expectation = self.expectation(description: "Failure")
        let client = MockClient(fakeResponses: .successWithEmptyRecipeInRecipeList)
        let recipeService = RecipeProvider(client: client)

        recipeService.fetchRecipes(with: [""]) { result in
            XCTAssertEqual(result, .failure(.noRecipeFound))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
