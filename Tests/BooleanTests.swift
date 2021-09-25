//
//  BooleanTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 26/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander

class BooleanTests: TisanderTest {
    func testTrue() {
        let input = """
[true]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Bool, true)
    }
    
    func testFalse() {
        let input = """
[false]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Bool, false)
    }
    
    func testMisspeltBoolean() {
        let input = """
[truee]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidJSON)
        }
    }
    
    func testPartialBoolean() {
        let input = """
[tru
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
}
