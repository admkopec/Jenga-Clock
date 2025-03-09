//
//  JengaClockAppClipApp.swift
//  Jenga–Clock AppClip
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI
import JengaClock
import FirebaseCore

@main
struct JengaClockAppClipApp: App {
    @State var showQuickRules = true
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                QuickSetupView()
                    .sheet(isPresented: $showQuickRules) {
                        QuickRulesView(showQuickRules: $showQuickRules)
                    }
            }
        }
    }
    
    init() {
        FirebaseApp.configure()
        let tracker = FirebaseTracker(isAppClip: true)
        Analytics.register(tracker: tracker)
    }
}
