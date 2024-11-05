//
//  Endpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

public struct Endpoint {
    let path: String
    let encoding: Encoding
    let method: HTTPMethods
    let withAuth: Bool
    let retries: Int
    let queryItems: [String : String]?
    let headers: [String : String]?

    public init(path: String,
                encoding: Encoding = .json,
                method: HTTPMethods = .get,
                withAuth: Bool = false,
                retries: Int = 0,
                queryItems: [String : String]? = nil,
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
