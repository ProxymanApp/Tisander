//
//  ObjectTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 26/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander

class ObjectTests: TisanderTest {
    func testEmptySet() {
        let input = """
{}
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual((json as? [JSON.ObjectElement])?.count, 0)
    }
    
    func testNestedEmptySet() {
        let input = """
[{}]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual((json as? [JSON.ArrayElement])?.count, 1)
        XCTAssert(json[0] is [JSON.ObjectElement])
    }
    
    func testOneElementSet() {
        let input = """
{"a":1}
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json["a"] as? Int, 1)
    }
    
    func testOneElementSetWithSpaces() {
        let input = """
{ "a" : 1 }
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json["a"] as? Int, 1)
    }
    
    func testArraySetElement() {
        let input = """
{"a":[]}
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssert(json["a"] is [JSON.ArrayElement])
    }
    
    func testUnterminatedSet() {
        let input = """
{
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.unterminatedObject)
        }
    }
    
    func testUnterminatedSetWithKey() {
        let input = """
{"a"
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidJSON)
        }
    }
    
    func testUnterminatedSetWithKeyAndColon() {
        let input = """
{"a":
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.unexpectedEndOfFile)
        }
    }
    
    func testUnterminatedSetWithKeyAndValue() {
        let input = """
{"a":1
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidJSON)
        }
    }
}
