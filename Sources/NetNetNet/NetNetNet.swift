//
//  NetNetNet.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 20/10/24.
//

public class NetNetNet {
    public static func initilize(scheme: String,
                                 host: String,
                                 clientId: String = "",
                                 clientSecret: String = "",
                                 oauthEndpoint: String = "") {
        NetConfig.setup(withConfig: Config(scheme: scheme,
                                           host: host,
                                           clientId: clientId,
                                           clientSecret: clientSecret,
                                           oauthEndpoint: oauthEndpoint))
    }
}
