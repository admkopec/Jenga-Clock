//
//  JengaClockApp.swift
//  Jenga Clock
//
//  Created by Adam Kopeć on 22/04/2022.
//

import SwiftUI

@main
struct JengaClockApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SetupView()
            }
            .navigationViewStyle(.stack)
        }
    }
}
