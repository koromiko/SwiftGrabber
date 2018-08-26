//
//  GrabberCoordinator.swift
//  libGrabber
//
//  Created by Neo on 19/08/2018.
//

import Foundation

public class GrabberCoordinator {
    /// Configuration used for accessing the server
    public struct RequestConfiguration {
        var token: String
        var url: String
        public init(token: String, url: String) {
            self.token = token
            self.url = url 
        }
    }

    public var outputPath: String?
    
    let storageService: StorageService
    let networkService: NetworkService

    var requestConfiguration: RequestConfiguration?

    var success: (() -> Void)?
    var failure: ((String) -> Void)?

    public init() {
        storageService = StorageService()
        networkService = NetworkService()
    }

    public func start(configuration: RequestConfiguration, success: @escaping () -> Void, failure: @escaping (String) -> Void) {

        let url: String = configuration.url
        let token: String = configuration.token

        self.success = success
        self.failure = failure

        let header = ["apiKey": token]
        networkService.fetch(url: url, header: header, complete: responseHandler)
    }

    var responseHandler: (Data?) -> Void {
        return { [weak self] data in
            if let data = data {
                let outputPath = self?.outputPath ?? "./"
                do {
                    try self?.storageService.save(data: data, to: outputPath, name: "results")
                    self?.success?()
                } catch let e {
                    self?.failure?("Save file error: \(e)")
                }

            } else {
                self?.failure?("No response or output path is invalid!")
            }
        }
    }
}
