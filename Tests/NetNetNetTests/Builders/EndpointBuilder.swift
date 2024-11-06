//
//  MocksEndpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 6/11/24.
//

import Foundation
@testable import NetNetNet


final class EndpointBuilder {
    private var path: String = ""
    private var encoding: BodyEncoding = .json
    private var method: HTTPMethods = .get
    private var withAuth: Bool = false
    private var retries: Int = 0
    private var queryItems: [URLQueryItem]?
    private var headers: [String : String]?
    
    func path(_ param: String) -> Self {
        path = param
        return self
    }
    
    func encoding(_ param: BodyEncoding) -> Self {
        encoding = param
        return self
    }
    
    func method(_ param: HTTPMethods) -> Self {
        method = param
        return self
    }
    
    func withAuth(_ param: Bool) -> Self {
        withAuth = param
        return self
    }
    
    func retries(_ param: Int) -> Self {
        retries = param
        return self
    }
    
    func queryItems(_ param: [URLQueryItem]?) -> Self {
        queryItems = param
        return self
    }
    
    func headers(_ param: [String : String]?) -> Self {
        headers = param
        return self
    }
    
    func build() -> Endpoint {
        .init(path: path,
              encoding: encoding,
              method: method,
              withAuth: withAuth,
              retries: retries,
              queryItems: queryItems,
              headers: headers)
    }
}
