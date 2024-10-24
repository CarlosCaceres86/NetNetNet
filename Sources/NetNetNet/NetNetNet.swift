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

public struct CacheConfig {
    var memoryCapacity: Int
    var diskCapacity: Int
    var diskPath: String
    
    public init(memoryCapacity: Int = 20 * 1024 * 1024,
                diskCapacity: Int = 100 * 1024 * 1024,
                diskPath: String = "NeNetNetCache") {
        self.memoryCapacity = memoryCapacity
        self.diskCapacity = diskCapacity
        self.diskPath = diskPath
    }
}
