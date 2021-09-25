//
//  NumberTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 26/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander


class NumberTests: TisanderTest {
    func testPositiveInt() {
        let input = """
[1]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Int, 1)
    }
    
    func testNegativeInt() {
        let input = """
[-1]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Int, -1)
    }
    
    func testPositiveDouble() {
        let input = """
[1.1]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Double, 1.1)
    }
    
    func testNegativeDouble() {
        let input = """
[-1.1]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Double, -1.1)
    }
    
    func testPositiveExponent() {
        let input = """
[1e2]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Int, 100)
    }
    
    func testExplicitPositiveExponent() {
        let input = """
[1e+2]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Int, 100)
    }
    
    func testNegativeExponent() {
        let input = """
[1e-2]
"""
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json[0] as? Double, 0.01)
    }
    
    func testExponentWithoutValue() {
        let input = """
[1e]
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidNumberMissingExponent)
        }
    }
    
    func testNegativeExponentWithoutValue() {
        let input = """
[1e-]
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidNumberMissingExponent)
        }
    }
    
    func testNumberWithoutFractional() {
        let input = """
[1.]
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidNumberMissingFractionalElement)
        }
    }
    
    func testNumberOnlyFractional() {
        let input = """
[.1]
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
    
    func testMissingExponentEndOfFile() {
        let input = """
[1e
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
    
    func testMissingFractionalEndOfFile() {
        let input = """
[1.
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
    
    func testOnlyDash() {
        let input = """
[-
"""
        do {
            let json = try JSON.parse(string: input)
            XCTFail("json is \(json)")
        } catch let e {
            XCTAssertEqual(e as? SerializationError, SerializationError.invalidArrayElement)
        }
    }
}
