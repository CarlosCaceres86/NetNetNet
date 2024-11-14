//
//  Stubabble.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 13/11/24.
//  Reference: https://www.swiftbysundell.com/articles/defining-testing-data-in-swift/

protocol Stubbable {
    static func stub() -> Self
}

extension Stubbable {
    func set<T>(_ keyPath: WritableKeyPath<Self, T>,
                to value: T) -> Self {
        var stub = self
        stub[keyPath: keyPath] = value
        return stub
    }
}
