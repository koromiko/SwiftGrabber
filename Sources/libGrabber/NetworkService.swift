//  NetworkService.swift
//  SwiftGrabberPackageDescription
//
//  Created by Neo on 26/07/2018.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

public class NetworkService {
    let urlSession: URLSessionProtocol
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    /// Fetch the data with given url, the complete clsure pass nil if server returns error
    func fetch(url: String, header: [String: String]?, complete: ((Data?) -> Void)?) {
        if let urlObj: URL = URL(string: url) {
            var request = URLRequest(url: urlObj)
            request.allHTTPHeaderFields = header
            let dataTask = urlSession.dataTask(with: request, completionHandler: { (data, _, error) in
                if error == nil {
                    complete?(data)
                } else {
                    complete?(nil)
                }
            })
            dataTask.resume()
        }
    }
}
