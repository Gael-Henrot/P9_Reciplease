//
//  MockNetworkService.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation
import Alamofire

protocol NetworkSession {
    func request<Parameters: Encodable>(_ convertible: URLConvertible,
                                             method: HTTPMethod,
                                             parameters: Parameters?,
                                             encoder: ParameterEncoder,
                                             headers: HTTPHeaders?,
                                             interceptor: RequestInterceptor?,
                                             requestModifier: RequestModifier?) -> DataRequest
    
    typealias RequestModifier = (inout URLRequest) throws -> Void
}
