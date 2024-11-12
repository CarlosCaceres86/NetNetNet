//
//  RequestTests.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 8/11/24.
//

import XCTest
@testable import NetNetNet

@available(iOS 15.0, *)
final class NetRequestTests: XCTestCase {
    private var sut: NetClient!
    private let netRquestFactoryMock: NetRequestFactoryMock = NetRequestFactoryMock()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = NetClient(endpoint: EndpointBuilder().build(),
                        netRequestFactory: netRquestFactoryMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testLoqueSea() throws {
        let url = try XCTUnwrap(URL(string: "https://somehost.com"))
        let request: URLRequest = .init(url: url)
        
        netRquestFactoryMock.urlRequest = request
        //sut.makeCall()
    }
}
