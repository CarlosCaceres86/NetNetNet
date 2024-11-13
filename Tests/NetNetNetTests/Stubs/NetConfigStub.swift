//
//  NetConfigStub.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 13/11/24.
//

@testable import NetNetNet

extension NetConfig: Stubbable {
    static func stub() -> NetConfig {
        return NetConfig(scheme: "https",
                         host: "somehost.com",
                         clientId: "",
                         clientSecret: "",
                         oauthEndpoint: "")
    }
    
}
