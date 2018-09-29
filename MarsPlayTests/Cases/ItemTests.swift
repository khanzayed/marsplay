//
//  HomeViewControllerTests.swift
//  MarsPlayTests
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 MarsPlay. All rights reserved.
//

import XCTest
@testable import MarsPlay

class ItemTests: XCTestCase {
    
    var item1 : Item!
    var item2 : Item!
    var item3 : Item!
    var item4 : Item!

    override func setUp() {
        super.setUp()
        
        let details1 : [String : String] = [
            "Title":"Batman Begins",
            "Year":"2018",
            "imdbID":"tt0372784",
            "Type":"movie",
            "Poster":"https://m.media-amazon.com/images/M/MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg"
        ]
        item1 = Item(details: details1, currentYear: 2018)
        
        
        let details2 : [String : String] = [
            "Title":"Batman Begins",
            "Year":"2005-2010",
            "imdbID":"tt0372784",
            "Type":"movie",
        ]
        item2 = Item(details: details2, currentYear: 2018)
        
        
        let details3 : [String : String] = [
            "Title":"Batman Begins",
            "Year":"2005-2009",
            "imdbID":"tt0372784",
            "Type":"movie",
            "Poster":"N/A"
        ]
        item3 = Item(details: details3, currentYear: 2018)
        
        
        let details4 : [String : String] = [
            "Title":"Batman Begins",
            "Year":"2005-",
            "imdbID":"tt0372784",
            "Type":"movie",
            "Poster":"https://m.media-amazon.com/images/M/MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg"
        ]
        item4 = Item(details: details4, currentYear: 2018)
    }

    override func tearDown() {
        super.tearDown()
        
        item1 = nil
        item2 = nil
        item3 = nil
        item4 = nil
    }

    func testNillImagePropertyFor1Item() {
        XCTAssertNotNil(item1.imageUrl) // This will pass
    }
    
    func testNillImagePropertyForLast2Items() {
        XCTAssertNotNil(item2.imageUrl) // This is suppose to fail
    }
    
    func testWrongURLPropertyFor3Item() {
        XCTAssertNotNil(item3.imageUrl) // This is suppose to fail
    }
    
    func testYearStringForItem3() {
        XCTAssert(item3.year == "2009") // This is suppose to fail
    }
    
    func testYearStringForItem2() {
        XCTAssert(item3.year == "13 years ago")// This will pass
    }
    
    func testYearStringForItem4() {
        XCTAssert(item3.year == "12 years ago") // This will fail
    }
    
    func testYearStringForSameYear() {
        XCTAssert(item1.year == "This year") // This will pass
    }

}
