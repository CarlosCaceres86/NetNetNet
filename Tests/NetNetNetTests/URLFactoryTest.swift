import XCTest
@testable import NetNetNet

final class URLFactoryTest: XCTestCase {
    private var sut: URLFactoryProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = URLFactory()
        NetNetNet.initialize(apiConfig: APIConfig(scheme: "https",
                                                  host: "testapi.com"),
                             cacheConfig: nil)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testShouldAddSinglePathToUrl() throws {
        let expectedUrl = "https://testapi.com/items"
        let endpoint = Endpoint(path: "/items",
                                method: .get)
        let urlRequest = sut.create(endpoint: endpoint)
        
        let builtUrl = try XCTUnwrap(urlRequest?.url?.absoluteString)
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testShouldAddMultipleQueryParametersToUrl() throws {
        let expectedUrl = "https://testapi.com/items?item1=1&item=1&item3=1"
        let endpoint = Endpoint(path: "/items",
                                method: .post,
                                queryItems: ["item1" : "1",
                                             "item" : "1",
                                             "item3" : "1"])
        let builtUrl = try XCTUnwrap(sut.create(endpoint: endpoint)?.url?.absoluteString)
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testShouldBuildGetRequest() throws {
        let endpoint = Endpoint(path: "/items",
                                method: .get)
        let urlRequest = try XCTUnwrap(sut.create(endpoint: endpoint))
        
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
    
    func testShouldBuildPostRequest() throws {
        let endpoint = Endpoint(path: "/items",
                                method: .post)
        let urlRequest = try XCTUnwrap(sut.create(endpoint: endpoint))
        
        XCTAssertEqual(urlRequest.httpMethod, "POST")
    }
    
    func testShouldHaveJsonEncodingHeaders() throws {
        let endpoint = Endpoint(path: "/items",
                                encoding: .json,
                                method: .get)
        let urlRequest = try XCTUnwrap(sut.create(endpoint: endpoint))
        
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/json")
    }
    
    func testShouldHaveUrlEncodingHeaders() throws {
        let endpoint = Endpoint(path: "/items",
                                encoding: .url,
                                method: .get)
        let urlRequest = try XCTUnwrap(sut.create(endpoint: endpoint))
        
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/x-www-form-urlencoded; charset=utf-8")
    }
    
    func testInvalidRequest() {
        let endpoint = Endpoint(path: "/items",
                                encoding: .url,
                                method: .get)
        sut = MockEmptyURLRequestURLFactory()
        XCTAssertNil(sut.create(endpoint: endpoint))
    }
}
