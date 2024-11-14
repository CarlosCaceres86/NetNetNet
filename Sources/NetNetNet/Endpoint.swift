//
//  Endpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

import Foundation


public struct Endpoint {
    var path: String
    var contentType: ContentType
    var method: HTTPMethods
    var withAuth: Bool
    var retries: Int
    var queryItems: [URLQueryItem]?
    var headers: [String : String]?
    
    public init(path: String,
                contentType: ContentType = .json,
                method: HTTPMethods = .get,
                withAuth: Bool = false,
                retries: Int = 0,
                queryItems: [URLQueryItem]? = nil,
                headers: [String : String]? = nil) {
        self.path = path
        self.contentType = contentType
        self.method = method
        self.withAuth = withAuth
        self.retries = retries
        self.queryItems = queryItems
        self.headers = headers
    }
}
