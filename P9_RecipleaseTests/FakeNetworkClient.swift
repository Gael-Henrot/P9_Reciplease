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
    //MARK: - Properties
    let fakeResponses: FakeResponses
    
    //MARK: - Methods
    func makeRequest<T>(for url: String, withMethod method: HTTPMethod?, parameters: [String : String]?, callback: @escaping ((Result<T, NetworkError>) -> Void)) where T : Decodable, T : Encodable {
        callback(fakeResponses.fakeResponse as! Result<T, NetworkError>)
    }
    
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
        return .init(fakeResponse: .success(FakeRecipeProviderResponses.correctRecipeList))
    }
    static var successWithEmptyRecipeList: MockClient.FakeResponses {
        return .init(fakeResponse: .success(FakeRecipeProviderResponses.emptyRecipeList))
    }
    static var successWithEmptyRecipeInRecipeList: MockClient.FakeResponses {
        return .init(fakeResponse: .success(FakeRecipeProviderResponses.emptyRecipeInRecipeList))
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
