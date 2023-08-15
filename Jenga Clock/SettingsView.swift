//
//  SettingsView.swift
//  Jenga Clock
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
        NavigationView {
            GeometryReader { reader in
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
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .font(.caption)
                            .padding(.bottom)
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))
//                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Spacer(minLength: (reader.size.width-8*12)/2)
                            Text("Settings")
                                .padding(.top, 8)
                                .font(.headline)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CloseButton {
                            shouldShowSelf = false
                        }
                    }
                }
            }
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
