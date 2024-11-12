//
//  NetSession.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 12/11/24.
//

import Foundation

public protocol NetSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

@available(iOS 15.0, *)
class NetSession: NetSessionProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await urlSession.data(for: request)
    }
}

@available(iOS 15.0, *)
public enum NetSessionFactory {
    nonisolated(unsafe) public static var netSession: NetSessionProtocol = NetSession(urlSession: urlSession)
    nonisolated(unsafe) private static var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        
        let session = URLSession(configuration: configuration)
        
        return session
    }()
}
