//
//  HTTPURLReponseTypes.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 13/11/24.
//

import Foundation


class HTTPURLReponseSuccess: HTTPURLResponse, @unchecked Sendable {
    init() {
        super.init(url: URL(string: "http")!,
                   statusCode: 200,
                   httpVersion: nil,
                   headerFields: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HTTPURLReponseNotFound: HTTPURLResponse, @unchecked Sendable {
    init() {
        super.init(url: URL(string: "http")!,
                   statusCode: 404,
                   httpVersion: nil,
                   headerFields: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
