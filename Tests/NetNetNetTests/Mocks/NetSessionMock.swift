//
//  NetSessionMock.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 8/11/24.
//

import Foundation
@testable import NetNetNet

final class NetSessionMock: NetSessionProtocol {
    private(set) var times: Int = 0
    var response: NetResponse = NetResponse(data: Data(), urlResponse: URLResponse())
    
    func data(for request: URLRequest) async throws -> NetResponse {
        times += 1
        
        return response
    }
}
