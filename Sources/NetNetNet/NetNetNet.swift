//
//  NetNetNet.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 20/10/24.
//

import Foundation

public final class NetNetNet {
    static var shared: NetNetNet {
        guard let shared = _shared else {
            fatalError("NetNetNet not yet initialized. Run initialize() first")
        }
        
        return shared
    }
    nonisolated(unsafe) private static var _shared: NetNetNet?
    let apiConfig: APIConfig?
    let cacheConfig: CacheConfig?
    var isCacheEnabled: Bool {
        return cacheConfig != nil ? true : false
    }
        
    public static func initialize(apiConfig: APIConfig,
                                  cacheConfig: CacheConfig? = nil) {
        _shared = NetNetNet(apiConfig: apiConfig,
                            cacheConfig: cacheConfig)
    }
    
    private init(apiConfig: APIConfig,
                 cacheConfig: CacheConfig?) {
        self.apiConfig = apiConfig
        self.cacheConfig = cacheConfig
        
        if let cacheConfig = cacheConfig {
            URLCache.shared = URLCache(memoryCapacity: cacheConfig.memoryCapacity,
                                       diskCapacity: cacheConfig.diskCapacity,
                                       diskPath: cacheConfig.diskPath)
        }
    }
}

public struct APIConfig {
    // Basic configuration
    var scheme: String = "https"
    var host: String = ""
    // OAuth Configuration
    var clientId: String = ""
    var clientSecret: String = ""
    var oauthEndpoint: String = ""
}

public struct CacheConfig {
    var memoryCapacity: Int = 20 * 1024 * 1024 // 20MB
    var diskCapacity: Int = 100 * 1024 * 1024 // 100MB
    var diskPath: String = "NeNetNetCache"
}
