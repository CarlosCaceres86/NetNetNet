//
//  URLFactory.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

import Foundation

protocol URLFactoryProtocol {
    func create(endpoint: Endpoint) -> URLRequest?
}

struct URLFactory: URLFactoryProtocol {
    private let netConfig: NetConfig
    
    init(netConfig: NetConfig) {
        self.netConfig = netConfig
    }
    
    func create(endpoint: Endpoint) -> URLRequest? {
        var components = URLComponents()
        
        components.scheme = netConfig.scheme
        components.host = netConfig.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad)
        
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach({ request.addValue($1, forHTTPHeaderField: $0) })
        
        switch endpoint.encoding {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .url:
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
