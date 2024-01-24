//
//  ProtocoloMock.swift
//  pokedataTests
//
//  Created by Camiilo on 24/01/24.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var testURLs: [URL: Data] = [:]

    override class func canInit(with request: URLRequest) -> Bool {
        return testURLs[request.url!] != nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let data = URLProtocolMock.testURLs[request.url!] {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
