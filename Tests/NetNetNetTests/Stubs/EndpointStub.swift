//
//  EndpointStub.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 13/11/24.
//

@testable import NetNetNet

extension Endpoint: Stubbable {
    static func stub() -> Endpoint {
        return Endpoint(path: "",
                        contentType: .json,
                        method: .get,
                        withAuth: false,
                        retries: 0,
                        queryItems: nil,
                        headers: nil)
    }
}
