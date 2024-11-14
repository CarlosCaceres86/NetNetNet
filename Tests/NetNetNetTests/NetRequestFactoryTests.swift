import XCTest
@testable import NetNetNet

final class NetRequestFactoryTests: XCTestCase {
    // sut stands for Service Under Test
    private var sut: NetRequestFactoryProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = NetRequestFactory(netConfig: NetConfig.stub())
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testGivenEndpointWithPathWhenCreatingNetRequestThenMatch() throws {
        let expectedUrl = "https://somehost.com/items"
        let endpoint = Endpoint.stub()
            .set(\.path, to: "/items")
        let urlRequest = sut.create(endpoint: endpoint)
        let builtUrl = try XCTUnwrap(urlRequest?.url?.absoluteString)
        
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testGivenEndpointWithQueryParamsWhenCreatingNetRequestThenMatch() throws {
        let expectedUrl = "https://somehost.com/items?item1=1&item=1&abc=1"
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "item1", value: "1"),
                                          URLQueryItem(name: "item", value: "1"),
                                          URLQueryItem(name: "abc", value: "1")]
        let endpoint = Endpoint.stub()
            .set(\.path, to: "/items")
            .set(\.queryItems, to: queryItems)
        let urlRequest = sut.create(endpoint: endpoint)
        let builtUrl = try XCTUnwrap(urlRequest?.url?.absoluteString)
        
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testGivenGetEndpointWhenCreatingNetRequestThenMatch() throws {
        let endpoint = Endpoint.stub()
            .set(\.method, to: .get)
        let urlRequest = sut.create(endpoint: endpoint)
        let httpMethod = try XCTUnwrap(urlRequest?.httpMethod)
        
        XCTAssertEqual(httpMethod, "GET")
    }
    
    func testGivenPostEndpointWhenCreatingNetRequestThenMatch() throws {
        let endpoint = Endpoint.stub()
            .set(\.method, to: .post)
        let urlRequest = sut.create(endpoint: endpoint)
        let httpMethod = try XCTUnwrap(urlRequest?.httpMethod)
        
        XCTAssertEqual(httpMethod, "POST")
    }
    
    func testGivenEndpointWithContentTypeJsonWhenCreatingNetRequestThenMatch() throws {
        let endpoint = Endpoint.stub()
            .set(\.contentType, to: .json)
        let result = sut.create(endpoint: endpoint)
        let urlRequest = try XCTUnwrap(result)
        
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/json")
    }
    
    func testGivenEndpointWithContentTypeUrlWhenCreatingNetRequestThenMatch() throws {
        let endpoint = Endpoint.stub()
            .set(\.contentType, to: .url)
        let result = sut.create(endpoint: endpoint)
        let urlRequest = try XCTUnwrap(result)
        
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/x-www-form-urlencoded; charset=utf-8")
    }
    
    func testGivenEndpointInvalidUrlWhenCreatingNetRequestThenNil() {
        let endpoint = Endpoint.stub()
        let netConfig = NetConfig.stub()
            .set(\.host, to: "badhost{}")
        
        sut = NetRequestFactory(netConfig: netConfig)
        let urlRequest = sut.create(endpoint: endpoint)
        
        XCTAssertNil(urlRequest)
    }
}
