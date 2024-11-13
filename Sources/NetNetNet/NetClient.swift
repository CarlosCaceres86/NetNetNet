//
//  Request.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 17/10/24.
//

import Foundation

public protocol NetClientProtocol {
    func makeRequest() async throws -> NetResponse
}

public class NetClient: NetClientProtocol {
    let netRequestFactory: NetRequestFactoryProtocol
    let endpoint: Endpoint
    let netSession: NetSessionProtocol
    
    public init(endpoint: Endpoint,
                netRequestFactory: NetRequestFactoryProtocol,
                netSession: NetSessionProtocol = NetSessionFactory.netSession) {
        self.endpoint = endpoint
        self.netRequestFactory = netRequestFactory
        self.netSession = netSession
    }
    
    public func makeRequest() async throws -> NetResponse {
        guard let request: URLRequest = netRequestFactory.create(endpoint: endpoint) else {
            throw URLError(.badURL)
        }
        
        let netResponse = try await netSession.data(for: request)
        
        guard let httpResponse: HTTPURLResponse = netResponse.urlResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let errorCode = URLError.Code(rawValue: httpResponse.statusCode)
            throw URLError(errorCode,
                           userInfo: [NSLocalizedDescriptionKey : "Unknown error"])
        }
                        
        return netResponse
    }
}
