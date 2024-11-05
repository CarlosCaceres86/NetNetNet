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
    
    public init(endpoint: Endpoint) {
        self.urlRequest = URLFactory().create(endpoint: endpoint)
    }
    
    /* Public Methods */
    public func makeCall<R: Codable>() async throws -> R {
        var data: Data
        
        if NetNetNet.shared.isCacheEnabled, let cachedData = try fetchDataFromCache() {
            data = cachedData
        } else {
            data = try await fetchDataFromRemote()
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(R.self, from: data) else {
            throw NetErrors.runtimeError("Error decoding response")
        }
                
        return decodedResponse
    }
    
    /* Private Methods */
    private func fetchDataFromRemote() async throws -> Data {
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
        
        if NetNetNet.shared.isCacheEnabled {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        }
        
        return data
    }
    
    private func fetchDataFromCache() throws -> Data? {
        guard let request = self.urlRequest else {
            throw NetErrors.runtimeError("Bad URL")
        }
        
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
            return nil
        }
        
        return cachedResponse.data
    }
    
}
