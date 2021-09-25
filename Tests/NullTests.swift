//
//  NullTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 26/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander

class NullTests: TisanderTest {
    func testTrue() {
        let input = """
[null]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssert(json[0] is JSON.NULL)
    }
    
    func testMisspeltNull() {
        let input = """
[nulll]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidJSON)
        }
    }
    
    func testMisspeltNullWithSpace() {
        let input = """
[nul ]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
}
