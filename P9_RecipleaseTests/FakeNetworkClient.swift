//
//  FakeNetworkService.swift
//  P9_RecipleaseTests
//
//  Created by Gaël HENROT on 24/09/2021.
//

import Foundation
import Alamofire
@testable import P9_Reciplease

struct MockClient: NetworkClientType {
    
    let fakeResponses: FakeResponses
    
    struct FakeResponses {
        let fakeResponse: Result<RecipeList, NetworkError>
    }
    
    func fetchRecipeData(with ingredientsList: [String], callback: @escaping (Result<RecipeList, NetworkError>) -> Void)
    {
        callback(fakeResponses.fakeResponse)
    }
}

extension MockClient.FakeResponses {
    static var success: MockClient.FakeResponses {
        return .init(fakeResponse: .success(FakeResponses.correctRecipeList))
    }
    static var successWithEmptyRecipeList: MockClient.FakeResponses {
        return .init(fakeResponse: .success(FakeResponses.emptyRecipeList))
    }
    static var successWithEmptyRecipeInRecipeList: MockClient.FakeResponses {
        return .init(fakeResponse: .success(FakeResponses.emptyRecipeInRecipeList))
    }
    static var failureWithRequestError: MockClient.FakeResponses {
        return .init(fakeResponse: .failure(.requestError))
    }
    static var failureWithWrongStatusCode: MockClient.FakeResponses {
        return .init(fakeResponse: .failure(.wrongStatusCode))
    }
    static var failureWithoutData: MockClient.FakeResponses {
        return .init(fakeResponse: .failure(.noData))
    }
    static var failureWithDecodingIssue: MockClient.FakeResponses {
        return .init(fakeResponse: .failure(.decodingIssue))
    }
}
