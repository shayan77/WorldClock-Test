//
//  WorldClockTests.swift
//  WorldClockTests
//
//  Created by Shayan Mehranpoor on 1/5/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import WorldClock

class WorldClockTests: XCTestCase {
    
    var worldClockUnderTest: Zone!
    
    override func setUp() {
        super.setUp()
        worldClockUnderTest = Zone()
        worldClockUnderTest.newTimeZone()
    }
    
    override func tearDown() {
        worldClockUnderTest = nil
        super.tearDown()
    }
    
    func testSecondsToHours() {
        worldClockUnderTest.gmtOffset = 10000
        _ = worldClockUnderTest.secondsToHoursMinutes()
        XCTAssertEqual(worldClockUnderTest.hour, 2, "Hour computed is wrong")
    }
    
    func testSecondsToMinutes() {
        worldClockUnderTest.gmtOffset = 10000
        _ = worldClockUnderTest.secondsToHoursMinutes()
        XCTAssertEqual(worldClockUnderTest.minute, 46, "Minute computed is wrong")
    }
    
    func testGetHourFromTimestamp() {
        worldClockUnderTest.timestamp = 1515414548
        _ = worldClockUnderTest.convertTimestampToHour()
        XCTAssertEqual(worldClockUnderTest.hour, 12, "Hour computed from timestamp is wrong")
    }
    
    func testGetMinuteFromTimestamp() {
        worldClockUnderTest.timestamp = 1515391164
        _ = worldClockUnderTest.convertTimestampToMinute()
        XCTAssertEqual(worldClockUnderTest.minute, 59, "Minute computed from timestamp is wrong")
    }
    
    func testGetSecondFromTimestamp() {
        worldClockUnderTest.timestamp = 1515391199
        _ = worldClockUnderTest.convertTimestampToSecond()
        XCTAssertEqual(worldClockUnderTest.second, 59, "Minute computed from timestamp is wrong")
    }
}
