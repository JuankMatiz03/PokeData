//
//  PokemonLoaderMock.swift
//  pokedataTests
//
//  Created by Camiilo on 24/01/24.
//

import Foundation
import Combine

class URLProtocolMockPokemon: URLProtocol {
    
    static var testURLs: [URL: Data] = [:]
    static var testError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return testURLs[request.url!] != nil || testError != nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let data = URLProtocolMock.testURLs[request.url!] {
            client?.urlProtocol(self, didLoad: data)
        }

        if let error = URLProtocolMockPokemon.testError {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
