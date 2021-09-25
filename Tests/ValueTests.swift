//
//  ValueTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 26/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander

class ValueTests: TisanderTest {
    func testKeys() {
        let input = """
{"1":null,"3":null,"2":null}
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json.keys, ["1", "3", "2"])
    }
    
    func testObjectValues() {
        let input = """
{"1":3,"3":2,"2":1}
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json.values as? [Int], [3, 2, 1])
    }
    
    func testArrayValues() {
        let input = """
[4,5,6]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json.values as? [Int], [4, 5, 6])
    }
    
    func testInvalidKeySubscript() {
        let input = """
[4,5,6]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertNil(json["a"])
    }
    
    func testInvalidArraySubscript() {
        let input = """
[4,5,6]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertNil(json[3])
    }
}
