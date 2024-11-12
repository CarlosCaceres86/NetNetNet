import XCTest
@testable import NetNetNet

final class NetRequestFactoryTests: XCTestCase {
    // sut stands for Service Under Test
    private var sut: NetRequestFactoryProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = NetRequestFactory(netConfig: NetConfigBuilder().build())
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testShouldAddSinglePathToUrl() throws {
        let expectedUrl = "https://somehost.com/items"
        let endpoint = EndpointBuilder()
            .path("/items")
            .build()
        let urlRequest = sut.create(endpoint: endpoint)
        let builtUrl = try XCTUnwrap(urlRequest?.url?.absoluteString)
        
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testShouldAddMultipleQueryParametersToUrl() throws {
        let expectedUrl = "https://somehost.com/items?item1=1&item=1&abc=1"
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "item1", value: "1"),
                                          URLQueryItem(name: "item", value: "1"),
                                          URLQueryItem(name: "abc", value: "1")]
        let endpoint = EndpointBuilder()
            .path("/items")
            .queryItems(queryItems)
            .build()
        let urlRequest = sut.create(endpoint: endpoint)
        let builtUrl = try XCTUnwrap(urlRequest?.url?.absoluteString)
        
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testShouldBuildGetRequest() throws {
        let endpoint = EndpointBuilder()
            .method(.get)
            .build()
        let urlRequest = sut.create(endpoint: endpoint)
        let httpMethod = try XCTUnwrap(urlRequest?.httpMethod)
        
        XCTAssertEqual(httpMethod, "GET")
    }
    
    func testShouldBuildPostRequest() throws {
        let endpoint = EndpointBuilder()
            .method(.post)
            .build()
        let urlRequest = sut.create(endpoint: endpoint)
        let httpMethod = try XCTUnwrap(urlRequest?.httpMethod)
        
        XCTAssertEqual(httpMethod, "POST")
    }
    
    func testShouldHaveJsonEncodingHeaders() throws {
        let endpoint = EndpointBuilder()
            .contentType(.json)
            .build()
        let result = sut.create(endpoint: endpoint)
        let urlRequest = try XCTUnwrap(result)
        
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/json")
    }
    
    func testShouldHaveUrlEncodingHeaders() throws {
        let endpoint = EndpointBuilder()
            .contentType(.url)
            .build()
        let result = sut.create(endpoint: endpoint)
        let urlRequest = try XCTUnwrap(result)
        
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/x-www-form-urlencoded; charset=utf-8")
    }
    
    func testInvalidRequest() {
        let endpoint = EndpointBuilder().build()
        let netConfig = NetConfigBuilder()
            .host("badhost{}")
            .build()
        
        sut = NetRequestFactory(netConfig: netConfig)
        let urlRequest = sut.create(endpoint: endpoint)
        
        XCTAssertNil(urlRequest)
    }
}
