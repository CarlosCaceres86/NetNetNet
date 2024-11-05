//
//  Types.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

public enum Encoding {
    case json, url
}

public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case connect = "CONNECT"
    case patch = "PATCH"    
}

enum NetErrors: Error {
    case runtimeError(String)
}
