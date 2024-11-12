//
//  Request.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 17/10/24.
//

import Foundation

public protocol NetRequestProtocol {
    func makeCall<R: Codable>() async throws -> R
}

@available(iOS 15.0, *)
public class NetClient: NetRequestProtocol {
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
    
    // MARK: Public Methods
    public func makeCall<R: Codable>() async throws -> R {
        guard let request: URLRequest = netRequestFactory.create(endpoint: endpoint) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await netSession.data(for: request)
        
        guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let errorCode = URLError.Code(rawValue: httpResponse.statusCode)
            throw URLError(errorCode,
                           userInfo: [NSLocalizedDescriptionKey : "Unknown error"])
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(R.self, from: data) else {
            throw URLError(.cannotDecodeRawData)
        }
                
        return decodedResponse
    }
}
