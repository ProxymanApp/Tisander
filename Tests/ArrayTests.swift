//
//  ArrayTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 26/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander

class ArrayTests: TisanderTest {
    func testEmptyArray() {
        let input = """
[]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual((json as? [JSON.ArrayElement])?.count, 0)
    }
    
    func testEmptyArrayWithWhitespace() {
        let input = """
[
]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual((json as? [JSON.ArrayElement])?.count, 0)
    }
    
    func testSimpleArray() {
        let input = """
[1,2,3]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Int, 1)
        XCTAssertEqual(json[1] as? Int, 2)
        XCTAssertEqual(json[2] as? Int, 3)
    }
    
    func testTrailingCommaArray() {
        let input = """
[1,]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual((json as? [JSON.ArrayElement])?.count, 1)
        XCTAssertEqual(json[0] as? Int, 1)
    }
    
    func testInvalidElementArray() {
        let input = """
[a]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
    
    func testUnterminatedSingleArray() {
        let input = """
[
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.unexpectedEndOfFile)
        }
    }
    
    func testUnterminatedArrayString() {
        let input = """
[""
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidJSON)
        }
    }
    
    func testUnterminatedMixedArray() {
        let input = """
[["",1,[""]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.unterminatedArray)
        }
    }
    
    func testCommaArray() {
        let input = """
[,]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
    
    func testDoubleTrailingCommaArray() {
        let input = """
[1,,1]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
    
    func testDoubleCommaArray() {
        let input = """
[1,,1]
"""
        do {
            _ = try JSON.parse(string: input)
            XCTFail()
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
}
