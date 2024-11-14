//
//  XCTestCaseUtils.swift
//  NetNetNet
//
//  Created by Carlos Cáceres González on 13/11/24.
//
import XCTest

public extension XCTestCase {
    func XCTAssertZero(_ value: Int, _ message: (Int) -> String = { "Int value \($0) is not equal to 0" }, file: StaticString = #filePath, line: UInt = #line) {
        guard value != 0 else { return }

        XCTFail(message(value), file: file, line: line)
    }

    func XCTAssertOne(_ value: Int, _ message: (Int) -> String = { "Int value \($0) is not equal to 1" }, file: StaticString = #filePath, line: UInt = #line) {
        guard value != 1 else { return }

        XCTFail(message(value), file: file, line: line)
    }
}
