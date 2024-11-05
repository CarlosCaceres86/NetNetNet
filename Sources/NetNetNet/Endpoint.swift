//
//  Endpoint.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

public class Endpoint {
    let path: String
    let encoding: Encoding
    let method: HTTPMethods
    let queryItems: [String : String]?
    let headers: [String : String]?

    public init(path: String,
                encoding: Encoding = .json,
                method: HTTPMethods = .get,
                queryItems: [String : String]? = nil,
                headers: [String : String]? = nil) {
        self.path = path
        self.encoding = encoding
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }
}
