import XCTest
@testable import NetworkingLayer

final class NetworkingLayerTests: XCTestCase {
    var response: NetworkResponse?
    
    func testSimpleUrl() {
        let urlString = "https://httpbin.org/"
        guard let url = URL(string: urlString) else {
            XCTFail("Failed to create URL")
            return
        }
        
        let expectation = expectation(description: "Retrieve response from URL")
        let simpleService = Request(baseURL: url, method: .get, path: "get")
        URLSessionProvider().request(service: simpleService) { response in
            self.response = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30)
        switch response {
        case .success(let json):
            if let jsonUrl = json["url"] as? String, jsonUrl == simpleService.absolutePath {
                
            } else {
                XCTFail("Failed to retrieve data from server")
            }
        default:
            XCTFail("Failed to retrieve data from server")
            break
        }
    }
}
