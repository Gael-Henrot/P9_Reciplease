//
//  MockURLProtocol.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 21/09/2021.
//

import Foundation

//URLRequest <-> URLSession <-> URLProtocols

enum MockURLProtocolError: Error {
    case noFakeAnswer
    case httpIncorrectStatusCode
}

class MockURLProtocol: URLProtocol {
    
    static var fakeResponse: [URL:(Data?, URLResponse?, Error?)]?
    
    override class func canInit(with request: URLRequest) -> Bool {
      return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
      return request
    }
    
    override func startLoading() {
        let mockRequest = self.request
        guard let mockRequestUrl = mockRequest.url else {
            return
        }
        
        guard let value = MockURLProtocol.fakeResponse?[mockRequestUrl] else {
            self.client?.urlProtocol(self, didFailWithError: MockURLProtocolError.noFakeAnswer)
            return
        }
        
        if let error = value.2 {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else if (value.1 as? HTTPURLResponse)?.statusCode != 200 {
            self.client?.urlProtocol(self, didFailWithError: MockURLProtocolError.httpIncorrectStatusCode)
        } else if let data = value.0 {
            self.client?.urlProtocol(self, didLoad: data)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
      // This is called if the request gets canceled or completed.
    }
    
}
