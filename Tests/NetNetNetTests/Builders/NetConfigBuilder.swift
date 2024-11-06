//
//  NetConfigBuilder.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 6/11/24.
//

@testable import NetNetNet

final class NetConfigBuilder {
    private var scheme: String = "https"
    private var host: String = "somehost.com"
    private var clientId: String = ""
    private var clientSecret: String = ""
    private var oauthEndpoint: String = ""
    
    func scheme(_ param: String) -> Self {
        scheme = param
        return self
    }
    
    func host(_ param: String) -> Self {
        host = param
        return self
    }
    
    func clientId(_ param: String) -> Self {
        clientId = param
        return self
    }
    
    func clientSecret(_ param: String) -> Self {
        clientSecret = param
        return self
    }
    
    func oauthEndpoint(_ param: String) -> Self {
        oauthEndpoint = param
        return self
    }
    
    func build() -> NetConfig {
        .init(scheme: scheme,
              host: host,
              clientId: clientId,
              clientSecret: clientSecret,
              oauthEndpoint: oauthEndpoint)
    }
    
}
