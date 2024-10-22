//
//  Endpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 17/10/24.
//

import Foundation

protocol Request {
    func sendRequest<R: Codable>() async throws -> R
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
        
        components.scheme = NetConfig.shared.config?.scheme
        components.host = NetConfig.shared.config?.host
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
        
        if encoding == .json {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    public func sendRequest<R: Codable>() async throws -> R {
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
        
        guard let reponse = try? JSONDecoder().decode(R.self, from: data) else {
            throw NetErrors.runtimeError("Error decoding response")
        }
        
        return reponse
    }
}
