//
//  Request.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 17/10/24.
//

import Foundation

protocol RequestProtocol {
    func makeCall<R: Codable>() async throws -> R
}

@available(iOS 15.0, *)
public class Request: RequestProtocol {
    let urlRequest: URLRequest?
    let netConfig: NetConfig
    
    public init(endpoint: Endpoint, netConfig: NetConfig) {
        self.netConfig = netConfig
        self.urlRequest = URLFactory(netConfig: netConfig).create(endpoint: endpoint)
    }
    
    // MARK: Public Methods
    public func makeCall<R: Codable>() async throws -> R {
        guard let request = self.urlRequest else {
            throw NetErrors.runtimeError("Bad URL")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetErrors.runtimeError("Invalid response")
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetErrors.runtimeError("Error response code: \(httpResponse.statusCode)")
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(R.self, from: data) else {
            throw NetErrors.runtimeError("Error decoding response")
        }
                
        return decodedResponse
    }
}
