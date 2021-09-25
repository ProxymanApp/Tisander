//
//  ToStringTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 27/06/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander
class ToStringTests: TisanderTest {
    func toString(input: String) -> String {
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return "" }
        
        return json.toJSONString()
    }
    
    func input(_ input: String, equals output: String) {
        var json: Value
        do { json = try JSON.parse(string: input) } catch let e { XCTFail((e as? SerializationError)?.rawValue ?? "Unknown exception"); return }
        
        XCTAssertEqual(json.toJSONString(), output)
    }
    
    func testEmptyString() {
        let input = """
[""]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testComplexString() {
        let input = """
["The quick fox jumps over the lazy dog"]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testBools() {
        let input = """
[true,false]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testInt() {
        let input = """
[0,1,-1]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testIntExponents() {
        self.input("[1e2,1.23e2,1e+2]", equals: "[100,123,100]")
    }
    
    func testDouble() {
        let input = """
[100.1,-100.1,0.0001,-0.001]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testDoubleExponents() {
        self.input("[10e-2]", equals: "[0.1]")
    }
    
    func testNull() {
        let input = """
[null,null]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testEmptyObject() {
        let input = """
{}
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testEmptyArray() {
        let input = """
[]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testObject() {
        let input = """
{"null":null,"int":1,"double":0.1,"array":[],"object":{}}
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testArrayOfEmptyArrays() {
        let input = """
[[],[],[]]
"""
        XCTAssertEqual(toString(input: input), input)
    }
    
    func testArrayOfEmptyObjects() {
        let input = """
[{},{},{}]
"""
        XCTAssertEqual(toString(input: input), input)
    }
}
