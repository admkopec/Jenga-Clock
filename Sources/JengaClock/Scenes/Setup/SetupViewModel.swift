// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  SetupViewModel.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 27/12/2024.
//

import SwiftUI

class SetupViewModel: ObservableObject {
    
    let minutesRange = 0...30
    lazy var minutesColumn: [String] = {
        var res = [String]()
        for i in minutesRange {
            res.append(String(format: NSLocalizedString("%d min", comment: "Number of minutes"), i))
        }
        return res
    }()
    
    let secondsRange = 0...59
    lazy var secondsColumn: [String] = {
        var res = [String]()
        for i in secondsRange {
            res.append(String(format: NSLocalizedString("%d sec", comment: "Number of seconds"), i))
        }
        return res
    }()

    // MARK: - State
    
    @Published var selectedTimeMin = 5
    @Published var selectedTimeSec = 0
    
    var startingTime: Int {
        selectedTimeMin * 60 + selectedTimeSec
    }
    
    var startButtonDisabled: Bool {
        selectedTimeMin == 0 && selectedTimeSec == 0
    }
}
