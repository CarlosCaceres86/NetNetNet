//
//  MocksURLFactory.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 5/11/24.
//

import Foundation
import NetNetNet

struct MockEmptyURLRequestURLFactory: URLFactoryProtocol {
    func create(endpoint: Endpoint) -> URLRequest? {
        return nil
    }
}
