// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  SettingsView.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("chooseStartingPlayer") private var chooseStartingPlayer = false
    @AppStorage("makeSounds") private var makeSounds = false
    @AppStorage("vibrateOnTimesUp") private var vibrateOnTimesUp = true
    @AppStorage("invertTextOrientation") private var invertTextOrientation = true
    
    @Binding var shouldShowSelf: Bool
    
    var body: some View {
        NavigationStack {
                ZStack{
                    Form {
                        Section {
                            Toggle(isOn: $chooseStartingPlayer) {
                                Text("Choose starting Player")
                            }
                            Toggle(isOn: $invertTextOrientation) {
                                Text("Timer faces the Player")
                            }
                        }
                        Section(header: Text("Sounds")) {
                            Toggle(isOn: $makeSounds) {
                                Text("Countdown sounds")
                            }
                            Toggle(isOn: $vibrateOnTimesUp) {
                                Text("Haptic feedback")
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        Text("Created with ❤️ by **Adam Kopeć**")
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .padding(.bottom)
                    }
                }
                #if !SKIP
                .background(Color(UIColor.systemGroupedBackground))
                #else
                .navigationTitle("Settings")
                #endif
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    #if !SKIP
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Settings")
                                .padding(.top, 8)
                                .font(.headline)
                        }
                    }
                    #endif
                    ToolbarItem(placement: .primaryAction) {
                        CloseButton {
                            shouldShowSelf = false
                        }
                    }
                }
        }
        .onAppear {
            Analytics.showScreen("SettingsView")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
        }.sheet(isPresented: .constant(true)) {
            SettingsView(shouldShowSelf: .constant(true))
        }
    }
}
