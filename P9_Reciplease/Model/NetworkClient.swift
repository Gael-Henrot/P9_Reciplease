//
//  NetworkClient.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 08/09/2021.
//

import Foundation
import Alamofire

class NetworkClient: NetworkClientType {
    
    //MARK: - Methods
    func makeRequest<T: Codable>(for url: String, withMethod method: HTTPMethod?, parameters : [String: String]?, callback: @escaping ((Result<T, NetworkError>) -> Void)) {
        AF.request(url, method: method ?? .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { [weak self] response in
                guard self != nil else { return }
                switch response.result {
                case .failure(let error):
                    switch error {
                    case .responseValidationFailed(reason: let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("No data provided by the server")
                            callback(.failure(.noData))
                        case .unacceptableStatusCode(code: let code):
                            print("Response status code was unacceptable: \(code)")
                                callback(.failure(.wrongStatusCode))
                        default:
                            print("A problem occurred during the request")
                            callback(.failure(.requestError))
                        }
                    case .responseSerializationFailed(reason: let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        switch reason {
                        case .inputFileNil, .inputDataNilOrZeroLength:
                            print("No data")
                            callback(.failure(.noData))
                        case .jsonSerializationFailed, .decodingFailed:
                            print("The data could not be decoded")
                            callback(.failure(.decodingIssue))
                        default:
                            print("A problem occurred during the serialization")
                            callback(.failure(.requestError))
                        }
                    default:
                        print("A problem occurred during the API request")
                        callback(.failure(.requestError))
                    }
                case .success(let response):
                    callback(.success(response))
                }
            }
    }
}

/// Lists possible errors that may occur during a network request.
enum NetworkError: Error {
    case requestError, noData, wrongStatusCode, decodingIssue
}

protocol NetworkClientType {
    func makeRequest<T: Codable>(for url: String, withMethod method: HTTPMethod?, parameters : [String: String]?, callback: @escaping ((Result<T, NetworkError>) -> Void))
}
