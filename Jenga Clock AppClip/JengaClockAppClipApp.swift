//
//  JengaClockAppClipApp.swift
//  Jenga Clock AppClip
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

@main
struct Jenga_Clock_AppClipApp: App {
    @State var showQuickRules = true
    var body: some Scene {
        WindowGroup {
            NavigationView {
                QuickSetupView()
                    .sheet(isPresented: $showQuickRules) {
                        QuickRulesView(showQuickRules: $showQuickRules)
                    }
            }
            .navigationViewStyle(.stack)
        }
    }
}
