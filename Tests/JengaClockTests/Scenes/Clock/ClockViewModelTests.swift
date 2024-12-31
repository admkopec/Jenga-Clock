// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  ClockViewModelTests.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 27/12/2024.
//

import XCTest
import OSLog
import SwiftUI
@testable import JengaClock

@available(macOS 13, *)
final class ClockViewModelTests: XCTestCase {
    let logger = Logger(subsystem: "com.kopeca.jenga-clock.tests", category: "ClockViewModelTests")
    
    let startingTime: Int = 3*60
    let shouldPlayerStart: Bool = true
    
    var sut: ClockViewModel!
    
    override func setUp() {
        sut = ClockViewModel(startingTime: startingTime, shouldPlayerStart: shouldPlayerStart)
    }
    
    func testSetup() {
        // Given
        let formattedString = String(format: "%02d:%02d", startingTime / 60, startingTime % 60)
        
        // Then
        XCTAssertEqual(sut.playerA, startingTime, "PlayerA's timeLeft should be equal to startingTime")
        XCTAssertEqual(sut.playerZ, startingTime, "PlayerZ's timeLeft should be equal to startingTime")
        XCTAssertEqual(sut.playerAsTurn || sut.playerZsTurn, shouldPlayerStart, "One of the players should start")
        
        XCTAssertEqual(sut.playerATimeLeft, formattedString, "PlayerA's timeLeft should be properly formatted")
        XCTAssertEqual(sut.playerZTimeLeft, formattedString, "PlayerZ's timeLeft should be properly formatted")
        
        XCTAssertEqual(sut.playerAsBackground, Color.green, "PlayerA's background should be green")
        XCTAssertEqual(sut.playerZsBackground, Color.green, "PlayerZ's background should be green")
    }
    
    func testTick() {
        // Given
        let timeLeft = startingTime - 1
        let formattedString = String(format: "%02d:%02d", timeLeft / 60, timeLeft % 60)
        
        sut.playerAsTurn = true
        sut.playerZsTurn = false
        sut.playerA = startingTime
        sut.playerZ = startingTime
        
        // When
        sut.tick()
        
        // Then
        XCTAssertEqual(sut.playerA, timeLeft, "PlayerA's timeLeft should be decremented by 1")
        XCTAssertEqual(sut.playerZ, startingTime, "PlayerZ's timeLeft should remain the same")
        XCTAssertEqual(sut.playerATimeLeft, formattedString, "PlayerA's timeLeft should be properly formatted")
        
        XCTAssertEqual(sut.playerAsBackground, Color.green, "PlayerA's background should be green")
        XCTAssertEqual(sut.playerZsBackground, Color.green, "PlayerZ's background should be green")
    }
    
    func testSwitchTurns() {
        // Given
        sut.playerAsTurn = true
        sut.playerZsTurn = false
        
        // When
        sut.switchTurns {
            XCTFail("Should not dismiss")
        }
        
        // Then
        XCTAssertFalse(sut.playerAsTurn, "PlayerA's turn should be switched")
        XCTAssertTrue(sut.playerZsTurn, "PlayerZ's turn should be switched")
    }
    
    func testBackgroundColors() {
        // Given
        sut.playerA = 0
        sut.playerZ = 19
        
        // Then
        XCTAssertEqual(sut.playerAsBackground, Color.red, "PlayerA's background should be red")
        XCTAssertEqual(sut.playerZsBackground, Color.orange, "PlayerZ's background should be orange")
    }
    
    func testDismissing() {
        // Given
        sut.playerA = 0
        sut.playerZ = 0
        let expectation = XCTestExpectation(description: "Should dismiss")
        
        // When
        sut.switchTurns {
            XCTAssertTrue(true, "Should dismiss")
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
