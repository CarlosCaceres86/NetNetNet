//
//  URLFactoryMock.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 8/11/24.
//

import Foundation
@testable import NetNetNet

final class NetRequestFactoryMock: NetRequestFactoryProtocol {
    private(set) var times: Int = 0
    var urlRequest: URLRequest?
    
    func create(endpoint: NetNetNet.Endpoint) -> URLRequest? {
        times += 1
        
        return urlRequest
    }
}
