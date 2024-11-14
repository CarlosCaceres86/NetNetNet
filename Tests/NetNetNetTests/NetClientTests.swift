//
//  NetClientTests.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 8/11/24.
//

import XCTest
@testable import NetNetNet

final class NetClientTests: XCTestCase {
    private var sut: NetClient!
    private var netRequestFactoryMock: NetRequestFactoryMock!
    private var netSessionMock: NetSessionMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        netRequestFactoryMock = NetRequestFactoryMock()
        netSessionMock = NetSessionMock()
        sut = NetClient(endpoint: Endpoint.stub(),
                        netRequestFactory: netRequestFactoryMock,
                        netSession: netSessionMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        netRequestFactoryMock = nil
        netSessionMock = nil
        
        try super.tearDownWithError()
    }
    
    func testGivenBadNetRequestWhenMakeRequestThenErrorMatch() async throws {
        netRequestFactoryMock.urlRequest = nil
        
        do {
            let _: NetResponse = try await sut.makeRequest()
        } catch (let error) {
            let urlError = try XCTUnwrap(error as? URLError)
            XCTAssertEqual(URLError.badURL, urlError.code)
            XCTAssertOne(netRequestFactoryMock.times)
            XCTAssertZero(netSessionMock.times)
        }
    }
    
    func testGivenDataAndURLResponseEmptyWhenMakeRequestThenErrorMatch() async throws {
        let url = try XCTUnwrap(URL(string: "https://somehost.com"))
        let request: URLRequest = .init(url: url)
        let netResponse: NetResponse = NetResponse(data: Data(), urlResponse: URLResponse())
        
        netRequestFactoryMock.urlRequest = request
        netSessionMock.response = netResponse
        
        do {
            let _: NetResponse = try await sut.makeRequest()
        } catch (let error) {
            let urlError = try XCTUnwrap(error as? URLError)
            XCTAssertEqual(URLError.badServerResponse, urlError.code)
            XCTAssertOne(netRequestFactoryMock.times)
            XCTAssertOne(netSessionMock.times)
        }
    }
    
    func testGivenURLResponseCodeNotFoundWhenMakeRequestThenErrorMatch() async throws {
        let url = try XCTUnwrap(URL(string: "https://somehost.com"))
        let request: URLRequest = .init(url: url)
        let netResponse: NetResponse = NetResponse(data: Data(), urlResponse: HTTPURLReponseNotFound())
        
        netRequestFactoryMock.urlRequest = request
        netSessionMock.response = netResponse
        
        do {
            let _: NetResponse = try await sut.makeRequest()
        } catch (let error) {
            let urlError = try XCTUnwrap(error as? URLError)
            XCTAssertEqual(URLError.Code(rawValue: 404), urlError.code)
            XCTAssertOne(netRequestFactoryMock.times)
            XCTAssertOne(netSessionMock.times)
        }
    }
    
    func testGivenUrlWhenMakeRequestThenResponseMatch() async throws {
        let url = try XCTUnwrap(URL(string: "https://somehost.com"))
        let request: URLRequest = .init(url: url)
        let data = try JSONEncoder().encode(ResponseMock(response: "some response"))
        let netResponse: NetResponse = NetResponse(data: data,
                                                   urlResponse: HTTPURLReponseSuccess())
        
        netRequestFactoryMock.urlRequest = request
        netSessionMock.response = netResponse
        
        let resultResponse: NetResponse = try await sut.makeRequest()
        XCTAssertEqual(netResponse, resultResponse)
        XCTAssertOne(netRequestFactoryMock.times)
        XCTAssertOne(netSessionMock.times)
    }
}
