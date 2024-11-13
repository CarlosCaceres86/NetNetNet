//
//  NetSession.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 12/11/24.
//

import Foundation

public protocol NetSessionProtocol {
    func data(for request: URLRequest) async throws -> NetResponse
}

class NetSession: NetSessionProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func data(for request: URLRequest) async throws -> NetResponse {
        let (data, response) = try await urlSession.data(for: request)
        return NetResponse(data: data, urlResponse: response)
    }
}

//public enum NetSessionFactory {
//    public static var netSession: NetSessionProtocol = NetSession(urlSession: urlSession)
//    private static var urlSession: URLSession = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpCookieStorage = nil
//        
//        return URLSession(configuration: configuration)
//    }()
//}

public struct NetSessionFactory {
    public static var netSession: NetSessionProtocol = NetSession(urlSession: urlSession)
    private static var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        
        return URLSession(configuration: configuration)
    }()
}
