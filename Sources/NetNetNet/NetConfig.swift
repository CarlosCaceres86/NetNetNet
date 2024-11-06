//
//  NetNetNet.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 20/10/24.
//

import Foundation


public struct NetConfig {
    // Basic configuration
    var scheme: String
    var host: String
    // OAuth Configuration
    var clientId: String
    var clientSecret: String
    var oauthEndpoint: String
    
    public init(scheme: String = "https",
                host: String,
                clientId: String  = "",
                clientSecret: String  = "",
                oauthEndpoint: String  = "") {
        self.scheme = scheme
        self.host = host
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.oauthEndpoint = oauthEndpoint
    }
}
