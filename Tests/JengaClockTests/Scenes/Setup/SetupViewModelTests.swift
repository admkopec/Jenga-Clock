// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  SetupViewModelTests.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 27/12/2024.
//

import XCTest
import OSLog
import Foundation
@testable import JengaClock

@available(macOS 13, *)
final class SetupViewModelTests: XCTestCase {
    let logger: Logger = Logger(subsystem: "com.kopeca.jenga-clock.tests", category: "SetupViewModelTests")
    
    var sut: SetupViewModel!
    
    override func setUp() {
        sut = SetupViewModel()
    }
    
    func testStartButtonDisabled() {
        // Given
        sut.selectedTimeMin = 0
        sut.selectedTimeSec = 0
        
        // When
        let result = sut.startButtonDisabled
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testStartingTimeComputation() {
        // Given
        sut.selectedTimeMin = 1
        sut.selectedTimeSec = 30
        
        // When
        let result = sut.startingTime
        
        // Then
        XCTAssertEqual(result, 90)
    }
}
