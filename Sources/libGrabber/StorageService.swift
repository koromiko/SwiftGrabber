//
//  StorageService.swift
//  SwiftGrabberPackageDescription
//
//  Created by Neo on 19/08/2018.
//

import Foundation

class StorageService {
    func save(data: Data, to path: String, name: String) throws {
        let path = URL(fileURLWithPath: path).appendingPathComponent("\(name).json")
        try data.write(to: path)
    }
}
