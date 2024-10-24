//
//  Endpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 17/10/24.
//

import Foundation

protocol Request {
    func makeCall<R: Codable>() async throws -> R
}

@available(iOS 15.0, *)
public class Endpoint: Request {
    let path: String
    let encoding: TargetTypeEncoding
    let method: HTTPMethods
    let queryItems: [String : String]?
    let headers: [String : String]?
    
    public init(path: String,
                encoding: TargetTypeEncoding = .json,
                method: HTTPMethods = .get,
                queryItems: [String : String]? = nil,
                headers: [String : String]? = nil) {
        self.path = path
        self.encoding = encoding
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }
    
    private var url: URL? {
        var components = URLComponents()
        
        components.scheme = NetNetNet.shared.apiConfig?.scheme
        components.host = NetNetNet.shared.apiConfig?.host
        components.path = path
        components.queryItems = queryItems?.map { URLQueryItem(name: $0, value: $1) }

        return components.url
    }
    
    private var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = self.method.rawValue
        headers?.forEach({ request.addValue($1, forHTTPHeaderField: $0) })
        
        switch encoding {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .url:
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
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
