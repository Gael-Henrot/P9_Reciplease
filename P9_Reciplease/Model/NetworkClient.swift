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
                case .failure(_):
                    callback(.failure(.requestError))
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
