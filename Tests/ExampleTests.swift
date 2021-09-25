//
//  ExampleTests.swift
//  TisanderTests
//
//  Created by Mike Bignell on 05/07/2018.
//  Copyright © 2018 Mike Bignell. All rights reserved.
//

import XCTest
@testable import Tisander

class ExampleTests: TisanderTest {
    func testReadme() {
        var output = [String]()
        
        func print(_ string: String) {
            output.append(string)
        }
        
        // Data
        let jsonString = """
{
    "Monday": [
        {
            "title": "Test Driven Development",
            "speaker": "Jason Shapiro",
            "time": "9:00 AM"
        },
        {
            "title": "Java Tools",
            "speaker": "Jim White",
            "time": "9:00 AM"
        }
    ],
    "Tuesday": [
        {
            "title": "MongoDB",
            "speaker": "Davin Mickleson",
            "time": "1:00 PM"
        },
        {
            "title": "Debugging with Xcode",
            "speaker": "Jason Shapiro",
            "time": "1:00 PM"
        }
    ]
}
"""
        
        var parsedJSON: Value?
        
        do {
            parsedJSON = try JSON.parse(string: jsonString)
        } catch let error {
            print("Could not parse JSON because of error: \(error)")
        }
        
        let keys = parsedJSON?.keys
        print(keys?.joined(separator: ", ") ?? "")
        
        // Prints:
        //  Monday, Tuesday
        
        let mondayValues = parsedJSON?["Monday"]?.values
        
        mondayValues?.forEach({ (day) in
            print((day["title"] as? String) ?? "")
        })
        
        // Prints:
        //  Test Driven Development
        //  Java Tools
        
        XCTAssertEqual(output.compactMap{$0}.joined(separator: "\n"), """
Monday, Tuesday
Test Driven Development
Java Tools
""")
    }
}
