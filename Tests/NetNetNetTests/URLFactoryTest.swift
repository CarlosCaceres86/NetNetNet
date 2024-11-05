import XCTest
@testable import NetNetNet

final class URLFactoryTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        NetNetNet.initialize(apiConfig: APIConfig(scheme: "https",
                                                  host: "testapi.com"),
                             cacheConfig: nil)
    }
    
    func testShouldAddSinglePathToUrl() throws {
        let expectedUrl = "https://testapi.com/items"
        let endpoint = Endpoint(path: "/items",
                                method: .get)
        let urlRequest = URLFactory.create(endpoint: endpoint)
        
        let builtUrl = try XCTUnwrap(urlRequest?.url?.absoluteString)
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testShouldAddMultipleQueryParametersToUrl() throws {
        let expectedUrl = "https://testapi.com/items?item1=1&item2=1&item3=1"
        let endpoint = Endpoint(path: "/items",
                                method: .post,
                                queryItems: ["item1" : "1",
                                             "item" : "1",
                                             "item3" : "1"])
        let builtUrl = try XCTUnwrap(URLFactory.create(endpoint: endpoint)?.url?.absoluteString)
        XCTAssertEqual(builtUrl, expectedUrl)
    }
    
    func testShouldBuildGetRequest() throws {
        let endpoint = Endpoint(path: "/items",
                                method: .get)
        let urlRequest = try XCTUnwrap(URLFactory.create(endpoint: endpoint))
        
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
    
    func testShouldBuildPostRequest() throws {
        let endpoint = Endpoint(path: "/items",
                                method: .post)
        let urlRequest = try XCTUnwrap(URLFactory.create(endpoint: endpoint))
        
        XCTAssertEqual(urlRequest.httpMethod, "POST")
    }
    
    func testShouldHaveJsonEncodingHeaders() {
        
    }
    
    func testShouldHaveUrlEncodingHeaders() {
        
    }
}
