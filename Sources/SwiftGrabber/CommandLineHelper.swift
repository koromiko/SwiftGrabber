//
//  CommandLineHelper.swift
//  libGrabber
//
//  Created by Neo on 19/08/2018.
//

import Foundation

struct CommandLineParameter {
    var outputPath: String?
    var url: String!
    var token: String!
}

class CommandLineHelper {
    enum ParserError: Error {
        case argumentError(String)
    }

    private let parameter: [String]
    private let environmentVariables: [String: String]

    var parsedParameter = CommandLineParameter()

    init(parameter: [String] = CommandLine.arguments,
         environmentVariables: [String: String] = ProcessInfo.processInfo.environment) {
        self.parameter = parameter
        self.environmentVariables = environmentVariables
    }

    /// Parse command line parameter and environment variable to a strong type obj
    func parse() throws {
        parseCommandLineParameter()
        parseEnvironmentVariables()
        try validateParameter()
    }

    private func parseCommandLineParameter() {
        for i in 0..<(parameter.count-1) {
            switch parameter[i] {
            case "-u":
                let url = parameter[i+1]
                parsedParameter.url = url
            case "-o":
                let path = parameter[i+1]
                parsedParameter.outputPath = path
            default: break
            }
        }
    }

    private func parseEnvironmentVariables() {
        if let token = environmentVariables["ACCESS_TOKEN"] {
            parsedParameter.token = token
        }
    }

    private func validateParameter() throws {
        if parsedParameter.url == nil {
            throw ParserError.argumentError("Please provide url by -u parameter")
        }
        if parsedParameter.token == nil {
            throw ParserError.argumentError("Please provide the token by setting the environment variable: ACCESS_TOKEN")
        }
    }
}
