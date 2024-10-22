//
//  Config.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 17/10/24.
//

final class NetConfig: Sendable {
    static var shared: NetConfig {
        guard let shared = _shared else {
            fatalError("NetConfig not yet initialized. Run setup(withConfig:) first")
        }
        
        return shared
    }
    
    nonisolated(unsafe) private static var _shared: NetConfig?
    let config: Config?
    
    static func setup(withConfig config: Config) {
        _shared = NetConfig(withConfig: config)
    }
    
    private init(withConfig config: Config) {
        self.config = config
    }
}

struct Config {
    // Basic configuration
    var scheme: String = "https"
    var host: String = ""
    // OAuth Configuration
    var clientId: String = ""
    var clientSecret: String = ""
    var oauthEndpoint: String = ""
}
