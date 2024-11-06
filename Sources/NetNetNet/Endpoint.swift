//
//  Endpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

import Foundation


public struct Endpoint {
    public var path: String
    public var encoding: BodyEncoding
    public var method: HTTPMethods
    public var withAuth: Bool
    public var retries: Int
    public var queryItems: [URLQueryItem]?
    public var headers: [String : String]?
    
    public init(path: String,
                encoding: BodyEncoding = .json,
                method: HTTPMethods = .get,
                withAuth: Bool = false,
                retries: Int = 0,
                queryItems: [URLQueryItem]? = nil,
                headers: [String : String]? = nil) {
        self.path = path
        self.encoding = encoding
        self.method = method
        self.withAuth = withAuth
        self.retries = retries
        self.queryItems = queryItems
        self.headers = headers
    }
}
