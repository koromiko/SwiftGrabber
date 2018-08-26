//
//  NetworkTests.swift
//  SwiftGrabberPackageDescription
//
//  Created by Neo on 16/08/2018.
//

import XCTest

@testable import libGrabber

class NetworkTests: XCTestCase {

    var sut: NetworkService?
    var mockSession: MockURLSession?

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = NetworkService(urlSession: mockSession!)
    }

    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }

    // Should pass currect url component
    func test_url_correct() {
        let url = "url://test"
        sut?.fetch(url: url, header: nil, complete: nil)
        XCTAssertEqual(url, mockSession!.targetURL)
    }

    // Should pass currect http method


    // Should pass currect http header


    // Should handle suucess response


    // Should handle error response


    // Should send request
    func test_request_sent() {

    }

    // The auth should be called before every auth-need request


    // The auth shouldn't be called for non-auth requests

}

class MockURLSession: URLSessionProtocol {
    var mockDataTask = MockDataTask()
    var targetURL: String?
    var resultData: Data?
    var errorData: Error?

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        targetURL = request.url?.absoluteString
        completionHandler(resultData, nil, errorData)
        return mockDataTask
    }
}

class MockDataTask: URLSessionDataTaskProtocol {
    var isResumeCalled = false
    func resume() {
        isResumeCalled = true
    }
}
